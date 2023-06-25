from fastapi import APIRouter , Response , status , Header
from services.securityService import JWT
from models import team
from services.databaseService import User , Team , TeamPlayers


router = APIRouter(
    prefix='/teams'
)


'''For now not trying to complicate it here. The request will return a team regardless if the user that requested it is in the league or not.'''

@router.get('/{teamId}' , status_code=status.HTTP_200_OK)
def getTeam(teamId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"] == True:
        try:
            requestedTeam = Team.getTeam(teamId=teamId)
            teamPlayers = TeamPlayers.getTeamPlayers(teamId=teamId)
            return {
                "success" : True,
                "team" : requestedTeam,
                "players" : teamPlayers
            }
        except Exception as e:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "Bad request"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification['error']
        }
    pass
            

        

