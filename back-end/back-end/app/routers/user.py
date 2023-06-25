from fastapi import APIRouter, status , Response , Header
import time

from models import user
from services.databaseService import User , Team
from services.securityService import hash , JWT



router = APIRouter(
    prefix='/users'
)

@router.post('/login' , status_code=status.HTTP_200_OK)
def login(payload : user.login , response : Response):
    password = hash(payload.password)
    foundUser = User.getUserByEmail(payload.email)
    
    if foundUser and foundUser['password'] == password:
        #token life span is equals to 10 days
        lifeSpan = 9000000000000000000000000000000000000000
        #token initiation time
        iat = int(time.time())

        header = {
                "alg" : 'sha256',
                "type" : 'jwt'
        }

        payload = {
            "user-id" : foundUser['id'],
            "iat" : iat,
            "exp" : iat + lifeSpan
        }

        token = JWT.sign(header=header , payload=payload)
        
        return {
            "success" : True , 
            "token" : token,
            "userName" : foundUser['userName'],
            'userId' : foundUser['id']
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return{
            "success" : False,
            "detail" : "Incorrect Credentials"
        }
    
@router.post('/' , status_code=status.HTTP_201_CREATED)
def create(payload : user.create , response : Response ):
    #hashing the password
    password = hash(payload.password)
    userCreated = User.createUser(email=payload.email , password=password , userName=payload.userName)
    if userCreated == True:
        newUser = User.getUserByEmail(email=payload.email)
        return {
            "success" : True , 
            "uri" : f"/users/{newUser['id']}"}
    else:
        response.status_code = status.HTTP_409_CONFLICT
        return {
            "success" : False,
            "detail" : "User with that email already exists"
        }

@router.patch('/{userId}/userName', status_code=status.HTTP_202_ACCEPTED)
def changeUserName(userId: int, payload: user.changeUserName , response : Response, token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification['valid'] == True:
        requestedUser = userId
        if tokenVerification['payload']['user-id'] == requestedUser:
            changedUserName = User.changeUserName(userName=payload.newUserName, id=requestedUser)
            if changedUserName == True:
                return{
                    "success" : True,
                    "detail" : f"Username Successfully changed to {payload.newUserName}"
                }
            else:
                response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                return {
                    "success" : False,
                    "detail" : "Internal Server Error"
                }

    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : "token is unauthorized"
        }

@router.patch('/{userId}/password' , status_code=status.HTTP_202_ACCEPTED)
def changePassword(userId : int , payload : user.changePassowrd , response : Response , token : str = Header()):                                                 
    tokenVerification = JWT.verify(token=token)
    if tokenVerification['valid'] == True:
        #verify if the user is only trying to delte there own account
        if tokenVerification['payload']['user-id'] == userId:
            #verify if the previous password is correct
            try:  
                previousPassword = User.getUserById(id=userId)[2]
            except Exception as e:
                response.status_code = status.HTTP_400_BAD_REQUEST
                return{
                    "success" : False,
                    "detail" : "User doesn't exist"
                }
            sentPreviousPassword = hash(payload.previousPassword)
            if previousPassword == sentPreviousPassword:
                newPassword = hash(payload.newPassword)
                passwordChanged = User.changePassword(id=userId , password=newPassword)
                if passwordChanged == True:
                    return {
                        "success" : True , 
                        "detail" : "Password has been changed"
                        }
                else:
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return {
                        "success" : False,
                        "detail" : "Internal Server Error"
                    }
            else:
                response.status_code = status.HTTP_401_UNAUTHORIZED
                return {
                    "success" : False,
                    "detail" : "Incorrect previous password"
                }
        else:
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return {
                "success" : False,
                "detail" : "Can't modify password for the requested user"
            }
    
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" :  "token is unautherized"
        }

@router.delete('/{userId}' , status_code=status.HTTP_200_OK)
def deleteUser(userId : int , payload : user.delete , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification['valid'] == True:
        #check if the user that is trying to delete 
        if tokenVerification["payload"]["user-id"] == userId:
            #check if the security password provided matches with the one on database
            try:
                requestedUserPassword = User.getUserById(id=userId)[2]
            except Exception as e:
                response.status_code = status.HTTP_400_BAD_REQUEST
                return {
                    "success" : False,
                    "detail" : "User doesn't exist"   
                }
            sentPassword = hash(payload.password)
            if sentPassword == requestedUserPassword:
                deletedUser = User.deleteUser(id=userId)
                if deletedUser == True:
                    return{
                        "success" : True,
                        "detail" : "User deleted"
                    }
                else:
                    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                    return{
                        "success" : False,
                        "detail" : "Internal Server Error"
                    }
            else:
                response.status_code = status.HTTP_401_UNAUTHORIZED
                return{
                    "success" : False,
                    "detail" : "Incorrect Password" 
                }        
        else:
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return{
                "success" : False,
                "detail" : "Can't delte the requested user"
            }
        pass
    
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {
            "success" : False,
            "detail" : "token is unautherized"
        }

@router.get('/{userId}/leagues/')
def getUserLeagues(userId : int , response : Response , token : str = Header()):
    tokenVerification = JWT.verify(token=token)
    if tokenVerification["valid"]:
        requestedUser = userId
        requestingUser = tokenVerification["payload"]["user-id"]
        if requestedUser == requestingUser:
            try:
                leagues = Team.getTeamsOfUser(userId=tokenVerification["payload"]["user-id"])['teams']
                return {
                    "success" : True,
                    "leagues" : leagues
                    }
            except Exception as e:
                response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
                return{
                    "success" : False,
                    "detail" : "Internal Server Error"
                }
        else:
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return{
                "success" : False,
                "detail" : "Not authorized to access requested user information"
            }
    else:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return{
            "success" : False,
            "detail" : tokenVerification["error"]
        }

#########################################
@router.get('/{userId}')
def getUserDetails(userId : int):
    '''This end point is in contention'''
    return []
