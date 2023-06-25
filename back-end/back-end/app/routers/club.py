from fastapi import APIRouter , Response , status
from fastapi.responses import FileResponse


router = APIRouter(
    prefix='/clubs'
)

@router.get("/{clubId}/pic")
def getClubLogo(clubId : int , response : Response):
    imgPath = f"../assets/teams/{clubId}.png"
    try:
        with open(file=imgPath , mode='r'):
            return FileResponse(path=imgPath) 
        
    except Exception as e:
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {
            "success" : False,
            "detail" : "Image doesn't exist" 
        }