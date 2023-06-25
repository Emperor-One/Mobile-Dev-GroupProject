from pydantic import BaseModel
from typing import List
from .player import Player


class updateTeam(BaseModel):
    '''Request body for updating a team'''
    team_id : int
    players : List[Player]

