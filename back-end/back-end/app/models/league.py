from pydantic import BaseModel
from typing import Optional , List
from .player import Player


class createLeague(BaseModel):
    '''Request body model for creating a league'''
    name : str
    tournament_id : int
    entry_fee : float = 0.0
    private : int = 0
    entry_code : str = ''
    players : List[Player] 

class deleteLeague(BaseModel):
    '''Request body model for deleting a league'''
    entry_code : Optional[str]

class updateLeague(BaseModel):
    '''Request body for updating a league'''
    name : str

class joinLeague(BaseModel):
    '''Request body for joining a league'''
    entry_code : Optional[str]
    players : List[Player]

class makeAdmin(BaseModel):
    '''Request body for making a person an admin'''
    id : int