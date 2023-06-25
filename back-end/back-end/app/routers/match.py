from fastapi import APIRouter , status , Response
from services.databaseService import Match

from datetime import datetime , date

router = APIRouter(
    prefix='/matches'
)


@router.get('/{year}-{month}-{day}' , status_code=status.HTTP_200_OK)
def getTodayMatches(year : int , month : int , day : int , response : Response):
    '''Returns all upcoming and current matches with the current score and elapsed time.'''
    try: 
        dateInEpoch = int(datetime(year , month , day).timestamp())
        result = Match.matchesForDate(date=dateInEpoch)
        return {
            "success" : True,
            "matches" : result
        }
    except Exception as e:
        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
        return{
            "success" : False,
            "detail" : "Internal Sever Error"
        }


@router.get('/{matchId}' , status_code=status.HTTP_200_OK)
def getMatchStats(matchId : int , response : Response):
    '''
    Returns the stats of a requested match. The stats include: 
            - home/away score 
            - home/away possession 
            - home/away total shots 
            - home/away shots on target
            - home/away saves
    '''
    try:
        result = Match.matchStats(matchId=matchId)
        return {
            "success" : True,
            "matchStats" : result
        }
    except Exception as e:
        response.status_code = status.HTTP_404_NOT_FOUND
        return {
            "success" : False,
            "detail" : "Couldn't find the requested match"
        }