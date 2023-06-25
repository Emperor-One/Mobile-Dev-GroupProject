from fastapi import FastAPI , Response , status
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins = ["*"],
    allow_credentials = True,
    allow_methods = ["*"],
    allow_headers = ["*"]
)

'''Include the different routers'''
from routers import user , team , match , league , player , club

app.include_router(router=club.router)
app.include_router(router=user.router)
app.include_router(router=team.router)
app.include_router(router=match.router)
app.include_router(router=league.router)
app.include_router(router=player.router)


        




