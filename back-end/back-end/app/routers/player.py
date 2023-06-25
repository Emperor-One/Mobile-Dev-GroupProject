from fastapi import APIRouter , status , Response, Header
from fastapi.responses import FileResponse

from services.databaseService import Player , PlayerStats
from services.securityService import JWT

router = APIRouter(
    prefix='/players'
)

@router.get('/')
def filterPlayers(response : Response , minPrice : int = 0, maxPrice : int = float('inf'), teamId : int = None , token : str = Header()  ):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        try:
            returnedPlayers = Player.filterPlayers(teamId=teamId , minPrice=minPrice , maxPrice=maxPrice)
            return returnedPlayers
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
            "detail" : tokenVerification["error"]
        }


@router.get('/{playerId}')
def getPlayerStat(playerId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        try:
            requestedStat = PlayerStats.getAllStats(playerId=playerId)
            return {
                "success" : True,
                "player" : requestedStat
            }
        except Exception as e:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {
                "success" : False,
                "detail" : "Player doesn't exist"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : tokenVerification["error"]
        }


@router.get('/{playerId}/pic')
def getPlayerPicture(playerId : int , response : Response):
    imagePath = f"../assets/players/{playerId}.png"
    try: 
        with open(file=imagePath , mode='r'):
            img = FileResponse(path=imagePath)
            return img
    except Exception as e:
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {
            "success" : False,
            "detail" : "Image doesn't exist" 
        }
    

