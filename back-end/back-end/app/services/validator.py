from services.databaseService import Player 

from models.player import Player as P 
from typing import List

def validatePlayers(players : List[P]):
    '''Function for checking whether the team roster submitted adheres to the rules'''
    
    playerKeys = ["id" , "name" , "clubId" , "price" , "position" , "injured"]
    playerList = []
    
    #check the number of players
    if len(players) < 5:
        return {
            "success" : False,
            "detail" : f"You need to add {(5-len(players))} to have a complete team"
        }
    
    #fetch all the players from the database
    for player in players:
        try:
            result = Player.getPlayer(playerId=player.player_id)
            print(result)
            print('#####')
            print(player.player_id)
            plDict = {}
            for key in playerKeys:
                plDict[key] = result[key]
            plDict["captain"] = player.captain
            plDict["reserve"] = player.reserve
            playerList.append(plDict)
        except Exception as e:
            raise e
        
    #do the checks you want to do
    positionAndTeamCount = {'ids' : [] , "reserve" : 0 , "captain" : 0}
    for player in playerList:
        
        #checking if a player is chosen more than once
        if player["id"] in positionAndTeamCount['ids']:
            return {
                "success" : False,
                "detail" : "Can't choose a player more than once"
            }
        else:
            positionAndTeamCount["ids"].append(player["id"]) 

    return {
        "success" : True,
        "players" : playerList
    }

def validateUser(userId : int , leagueId : int):
    '''A function that checks whether a user account fulfiles the requierments to join a league'''
    return {
        "success" : True,
        "detail" : "dummy validator"
    }
