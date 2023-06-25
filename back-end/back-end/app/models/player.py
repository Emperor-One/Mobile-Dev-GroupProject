from pydantic import BaseModel

class Player(BaseModel):
    '''This is a model for adding a player to a team'''
    player_id : int
    captain : int
    reserve : int