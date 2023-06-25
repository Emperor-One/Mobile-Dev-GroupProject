from pydantic import BaseModel

class login(BaseModel):
    '''Request body model for logging in'''
    email : str
    password : str


class create(BaseModel):
    '''Request body model for creating a user'''
    userName : str
    email : str
    password : str


class changePassowrd(BaseModel):
    '''Request body for changing password'''
    previousPassword : str
    newPassword : str

class changeUserName(BaseModel):
    '''Request body for changing username'''
    newUserName: str

class delete(BaseModel):
    '''Request body for deleting a user's account'''
    password : str