import hashlib , base64 , time , json

SECRET = "2t~c~~Fh2iqsvGZ84RMgPWej;Kr9IaED}1'BaHmdopFbv0{[G1"


def hash(string):
    return hashlib.sha1(string.encode()).hexdigest()

#HS256
class JWT:
    
    @staticmethod
    def sign(header  , payload  , secret : str = SECRET):
        
        #changing the header and payload to base64
        __header = base64.urlsafe_b64encode(json.dumps(header).encode()).decode()
        __payload = base64.urlsafe_b64encode(json.dumps(payload).encode()).decode()
        

        __toBeHashed = __header + '.' + __payload + '.' + secret
        
        __signature = hashlib.sha256(__toBeHashed.encode()).hexdigest()
        
        return '.'.join([__header,__payload,__signature]) 
    
    @staticmethod
    def verify(token : str , secret : str = SECRET):
        
        try:
            header , payload , signature = token.split('.')
            __header = json.loads(base64.urlsafe_b64decode(header.encode()).decode().replace('\'' , '\"'))
            __payload = json.loads(base64.urlsafe_b64decode(payload.encode()).decode().replace('\'' , '\"'))
        except Exception as e:
            return {"valid" : False}
        
        # check if token has expiered
        timedOut = int(__payload['exp']) < int(time.time())  
        
        #check if the token is intact and hasn't timed out and return accordingly
        if JWT.sign(__header , __payload , secret).split('.')[2] == signature and not timedOut:
            return {'valid' : True , 'payload' : __payload}
        
        elif timedOut:
            return {
                'valid' : False,
                'error' : "Token has expired!"
            }
        
        return {
            'valid' : False,
            'error' : 'Invalid Token!'
            } 



if __name__ == "__main__":

    header = {
                "alg" : 'sha256',
                "type" : 'jwt'
            }

    payload = {
            "user-name" : 'tinsa',
            "iat" : 1668702026,
            "exp" : 1668702026 + 3600
        }

    print(JWT.sign(header , payload))
    print("same: ", JWT.verify('eyJhbGciOiAic2hhMjU2IiwgInR5cGUiOiAiand0In0=.eyJ1c2VyLW5hbWUiOiAidGluc2EiLCAiaWF0IjogMTY2ODcwMjAyNiwgImV4cCI6IDE2Njg3MDU2MjZ9.debc44a59855b79dfd8774df61db171210d3cab655a1d04e21400e0ce633aa98'))
    
    pass