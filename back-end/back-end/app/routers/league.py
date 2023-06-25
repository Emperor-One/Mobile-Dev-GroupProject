from fastapi import APIRouter , Response , Header , status
from datetime import date

from models import league
from services.databaseService import League , Team , TeamPlayers , LeagueAdmin
from services.securityService import JWT , hash 
from services.validator import validatePlayers , validateUser


router = APIRouter(
    prefix='/leagues'
)


@router.get('/')
def getLeagues(response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        try:
            leagues = League.getPublicLeagues()
            return {
                "success" : True,
                "leagues" : leagues 
            }
        except Exception as e:
            response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
            return {
                "success" : False,
                "detail" : "Internal Sever Error"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" :  tokenVerification["error"]
        }

@router.get('/{leagueId}')
def getLeague(leagueId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        requestedLeague = League.getLeague(leagueId=leagueId)
        if requestedLeague["success"]:
            leagueTeam = League.getTeams(leagueId=leagueId)
            return {
                "success" : True,
                "league" : requestedLeague["league"],
                "teams" : leagueTeam
            }
        else:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "Couldn't locate league"
            }  
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.post('/')
def createLeague(payload : league.createLeague , response : Response ,  token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        #validate the team
        validationResult = validatePlayers(players=payload.players)
        if validationResult["success"]:
            #create the league
            createdLeague = League.createLeague(
                owner=tokenVerification["payload"]["user-id"],
                tournament_id=payload.tournament_id,
                name=payload.name,
                date=date.today().strftime(format='%Y-%m-%d'),
                private=payload.private,
                entry_code=payload.entry_code,
                entry_fee=payload.entry_fee
            )
            if createdLeague["success"]:
                #createTeam
                createdTeam = Team.createTeam(
                    userId=tokenVerification["payload"]["user-id"],
                    leagueId=createdLeague["newLeague"],
                    date=date.today().strftime(format='%Y-%m-%d')
                )

                if createdTeam["success"]:
                    #add players to team
                    for player in validationResult["players"]:
                        result = TeamPlayers.addPlayerToTeam(
                            teamId=createdTeam["newTeam"],
                            playerId=player["id"],
                            captain=player["captain"],
                            reserve=player["reserve"]
                        )
                        if result != True:
                            League.deleteLeague(leagueId=createdLeague["newLeague"])
                            response = status.HTTP_500_INTERNAL_SERVER_ERROR
                            return {
                                "success" : False,
                                "detail" : "Internal server error"
                            }
                    
                    #league and team creation was successful
                    return {
                        "success" : True,
                        "uri" : f'''leagues/{createdLeague["newLeague"]}'''
                    }

                else:
                    #delete the created league
                    League.deleteLeague(leagueId=createdLeague["newLeague"])
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return{
                    "success" : False,
                    "detail" : "Internal server error"
                }
            else:
                response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                return{
                    "success" : False,
                    "detail" : "Internal server error"
                }
        else:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return{
                "success" : False,
                "detail" : validationResult["detail"]
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.delete('/{leagueId}')
def deleteLeague(leagueId : int , payload : league.deleteLeague , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        try:
            requestedLeague = League.getLeague(leagueId=leagueId)
            if requestedLeague["league"]["private"]:
                if requestedLeague["league"]["entryCode"] == payload.entry_code:
                    try:
                        League.deleteLeague(leagueId=leagueId)
                        return {
                            "success" : True
                        }
                    except Exception as e:
                        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                        return {
                            "success" : False,
                            "detail" : "Internal server error"
                        }
                else:
                    response.status_code = status.HTTP_403_FORBIDDEN
                    return {
                        "success" : False,
                        "detail" : "Incorrect code"
                    }            
            else:
                try:
                    League.deleteLeague(leagueId=leagueId)
                    return {
                        "success" : True
                    }
                except Exception as e:
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return {
                        "success" : False,
                        "detail" : "Internal server error"
                    }
                    
        except Exception as e:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "Couldn't find league"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.patch('/{leagueId}')
def updateLeague(leagueId : int , payload : league.updateLeague , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"] == True:
        try:
            changeName = League.updateName(leagueId=leagueId , newName=payload.name)
            return{
                "success" : True,
                "detail" : f"League name successfuly updated to {payload.name}"
            }
        except Exception as e:
            response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
            return{
                "success" : False,
                "detail" : "Internal Server Error"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return{
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.post('/{leagueId}/teams')
def joinLeague(leagueId : int , payload : league.joinLeague , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        #check if the league exists
        try:
            requestedLeague = League.getLeague(leagueId=leagueId)
            if requestedLeague['league']["private"]:
                #check the entry code
                if payload.entry_code == requestedLeague['league']["entryCode"]:
                    #check if the user isn't already in it
                    user = League.checkForUser(leagueId=leagueId , userId=tokenVerification["payload"]["user-id"])
                    if user['success']:
                        if user['exists']:
                            response.status_code = status.HTTP_400_BAD_REQUEST
                            return {
                                "success" : False,
                                "detail" : "User already registered in the league"
                            }
                        else:
                            #validate the user
                            validationResult = validateUser(userId=tokenVerification["payload"]["user-id"] , leagueId=leagueId)
                            if validationResult["success"]:
                                #validate the team
                                validationResult = validatePlayers(players=payload.players)
                                if validationResult["success"]:
                                    #create the team
                                    createdTeam = Team.createTeam(
                                        userId=tokenVerification["payload"]["user-id"],
                                        leagueId=leagueId,
                                        date=date.today().strftime(format='%Y-%m-%d')
                                    )
                                    if createdTeam["success"]:
                                        #add players to team
                                        for player in validationResult["players"]:
                                            result = TeamPlayers.addPlayerToTeam(
                                                teamId=createdTeam["newTeam"],
                                                playerId=player["id"],
                                                captain=player["captain"],
                                                reserve=player["reserve"]
                                            )
                                            if result != True:
                                                Team.deleteTeam(teamId = createdTeam["newTeam"])
                                                response = status.HTTP_500_INTERNAL_SERVER_ERROR
                                                return {
                                                    "success" : False,
                                                    "detail" : "Internal server error"
                                                }
                                        return {
                                            "success" : True,
                                            "uri" : f'''leagues/{leagueId}/teams/{createdTeam["newTeam"]}'''
                                        }
                                    else:
                                        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                                        return {
                                            "success" : False,
                                            "detail" : "Internal server error"
                                        }
                                else:
                                    response.status_code = status.HTTP_400_BAD_REQUEST
                                    return {
                                        "success" : False,
                                        "detail" : validationResult["detail"]
                                    }
                            else:
                                response.status_code = status.HTTP_400_BAD_REQUEST
                                return {
                                    "success" : False , 
                                    "detail" : validationResult["detail"]
                                }
                    else:
                        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                        return {
                            "success" : False,
                            "detail" : "Internal server error"
                        }
                else:    
                    response.status_code = status.HTTP_403_FORBIDDEN
                    return {
                        "success" : False,
                        "detail" : "Incorrect code"
                    }
            else:
                #check if the user isn't already in it
                user = League.checkForUser(leagueId=leagueId , userId=tokenVerification["payload"]["user-id"])
                print(user)
                if user['success']:
                    if user['exists']:
                        response.status_code = status.HTTP_400_BAD_REQUEST
                        return {
                            "success" : False,
                            "detail" : "User already registered in the league"
                        }
                    else:
                        #validate the user
                            validationResult = validateUser(userId=tokenVerification["payload"]["user-id"] , leagueId=leagueId)
                            if validationResult["success"]:
                                #validate the team
                                validationResult = validatePlayers(players=payload.players)
                                if validationResult["success"]:
                                    #create the team
                                    createdTeam = Team.createTeam(
                                        userId=tokenVerification["payload"]["user-id"],
                                        leagueId=leagueId,
                                        date=date.today().strftime(format='%Y-%m-%d')
                                    )
                                    if createdTeam["success"]:
                                        #add players to team
                                        for player in validationResult["players"]:
                                            result = TeamPlayers.addPlayerToTeam(
                                                teamId=createdTeam["newTeam"],
                                                playerId=player["id"],
                                                captain=player["captain"],
                                                reserve=player["reserve"]
                                            )
                                            if result != True:
                                                Team.deleteTeam(teamId = createdTeam["newTeam"])
                                                response = status.HTTP_500_INTERNAL_SERVER_ERROR
                                                return {
                                                    "success" : False,
                                                    "detail" : "Internal server error"
                                                }
                                        return {
                                            "success" : True,
                                            "uri" : f'''leagues/{leagueId}/teams/{createdTeam["newTeam"]}'''
                                        }
                                    else:
                                        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                                        return {
                                            "success" : False,
                                            "detail" : "Internal server error"
                                        }
                                else:
                                    response.status_code = status.HTTP_400_BAD_REQUEST
                                    return {
                                        "success" : False,
                                        "detail" : validationResult["detail"]
                                    }
                            else:
                                response.status_code = status.HTTP_400_BAD_REQUEST
                                return {
                                    "success" : False , 
                                    "detail" : validationResult["detail"]
                                }
                else:
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return {
                        "success" : False,
                        "detail" : "Internal server error"
                    }
        
        except Exception as e:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "League doesn't exist"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.delete("/{leagueId}/teams/{teamId}/leave")
def leaveLeague(leagueId : int , teamId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        try:
            requestedTeam = Team.getTeam(teamId=teamId)
            if requestedTeam["user_id"] == tokenVerification["payload"]["user-id"]:
                if requestedTeam["league_id"] == leagueId:
                    #delete Team
                    deleteTeam = Team.deleteTeam(teamId=teamId)
                    if deleteTeam == True:
                        return {
                            "success" : True,
                            "detail" : "Team deleted successfully"
                        }
                    
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return {
                        "success" : False,
                        "detail" : "Internal server error"
                    }

                else:
                    response.status_code = status.HTTP_400_BAD_REQUEST
                    return {
                        "success" : False,
                        "detail" : "Team with the specified URI doesn't exist"
                    }
            else:
                response.status_code = status.HTTP_400_BAD_REQUEST
                return {
                    "success" : False,
                    "detail" : "Team doesn't belong to requesting user"
                } 
        except Exception as e:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "Team doesn't exist"
            }
    
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }
    
@router.delete("/{leagueId}/teams/{teamId}")
def removeTeam(leagueId : int , teamId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        userId = tokenVerification["payload"]["user-id"]
        
        try:
            requestedTeam = Team.getTeam(teamId=teamId)
        except:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return{
                "success" : False,
                "detail" : "No such team"
            }
        
        try:
            if requestedTeam["league_id"] == leagueId:
                try:
                    isOwner = League.checkOwner(leagueId=leagueId , userId=userId)
                    isAdmin = LeagueAdmin.checkAdmin(leagueId=leagueId , userId=userId)
                    if isOwner or isAdmin:
                        #try deleting the team
                        try:
                            Team.deleteTeam(teamId=teamId)
                            return{
                                "success" : True
                            }
                        except:
                            response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                            return{
                                "success" : False,
                                "detail" : "Internal Server Error"
                            }
                    else:
                        response.status_code = status.HTTP_401_UNAUTHORIZED
                        return{
                            "success" : False,
                            "detail" : "You are not autherized to perform the requested action"
                        }

                except Exception as e:
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return{
                        "success" : False,
                        "detail" : "Internal Server Error"
                    }
            else:
                response.status_code = status.HTTP_400_BAD_REQUEST
                return{
                    "success" : False,
                    "detail" : "No such team in the league"
                }
        except:    
            response.status_code = status.HTTP_400_BAD_REQUEST
            return{
                "success" : False,
                "detail" : "No such team"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }

@router.post("/{leagueId}/admins")
def makeAdmin(leagueId : int , payload : league.makeAdmin , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification['valid'] == True:
        try:
            mkAdmin = LeagueAdmin.makeAdmin(leagueId=leagueId , userId=payload.id)
            return {
                "success" : True,
                "detail" : "Successfully added to admins"
            }
        except Exception as e:
            response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
            return {
                "success" : False,
                "detail" : "Internal Server Error"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification['error']
        }
    
@router.delete("/{leagueId}/admins/{userId}")
def removeAdmin(leagueId : int , userId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification['valid'] == True:
        try:
            mkAdmin = LeagueAdmin.removeAdmin(leagueId=leagueId , userId=userId)
            return {
                "success" : True,
                "detail" : "Successfully removed from admins"
            }
        except Exception as e:
            response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
            return {
                "success" : False,
                "detail" : "Internal Server Error"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification['error']
        }


