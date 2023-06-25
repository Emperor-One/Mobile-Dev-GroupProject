import requests , json , os

def getTeamAndPlayerImages():
    baseFile = "../assets/"
    teamsPath = 'https://api.sofascore.com/api/v1/unique-tournament/17/season/41886/standings/total'
    header = {
        "authority":"api.sofascore.com",
        "method":"GET",
        "scheme" : "https",
        "accept-language": "en-US,en;q=0.9",
        "cache-control" : "max-age=0",
        "origin" : "https://www.sofascore.com",
        "referer" : "https://www.sofascore.com/",
        "sec-ch-ua" : '''"Google Chrome";v="105", "Not)A;Brand";v="8", "Chromium";v="105"''',
        "sec-ch-ua-platform" : "Windows",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/105.0.0.0 Safari/537.36"
    }


    #get all the teams and ids
    response = requests.get(url=teamsPath , headers=header).content
    tables = json.loads(response)["standings"][0]


    for row in tables["rows"]:
        teamId = row["team"]["id"] 
        logoURI = f"https://api.sofascore.app/api/v1/team/{teamId}/image"
        fetchedLogog = requests.get(url=logoURI , headers=header).content
        path = baseFile + f'teams/{teamId}.png'
        print(path)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path , "wb") as file:
            file.write(fetchedLogog)
            file.close()

        #get all the players of each team and save them
        teamPlayersPath = f'https://api.sofascore.com/api/v1/team/{teamId}/players'
        foundPlayers = json.loads(requests.get(url=teamPlayersPath , headers=header).content)["players"]

        for player in foundPlayers:
            playerId = player["player"]["id"] 
            playerURI = f'https://api.sofascore.app/api/v1/player/{playerId}/image'
            imagePath = baseFile + f'players/{playerId}.png'
            os.makedirs(os.path.dirname(imagePath), exist_ok=True)
            fetchPlayerPic = requests.get(url=playerURI , headers=header).content
            with open(imagePath , 'wb') as file:
                file.write(fetchPlayerPic)
                file.close()


def addPlayersToDB():
    import random
    from databaseService import Club , Player

    teamsPath = 'https://api.sofascore.com/api/v1/unique-tournament/17/season/41886/standings/total'
    header = {
        "authority":"api.sofascore.com",
        "method":"GET",
        "scheme" : "https",
        "accept-language": "en-US,en;q=0.9",
        "cache-control" : "max-age=0",
        "origin" : "https://www.sofascore.com",
        "referer" : "https://www.sofascore.com/",
        "sec-ch-ua" : '''"Google Chrome";v="105", "Not)A;Brand";v="8", "Chromium";v="105"''',
        "sec-ch-ua-platform" : "Windows",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/105.0.0.0 Safari/537.36"
    }

    response = requests.get(url=teamsPath , headers=header).content
    tables = json.loads(response)["standings"][0]


    for row in tables["rows"]:
        #adding clubs
        teamId = row["team"]["id"] 
        name = row["team"]["name"]
        tournamentId = 17
        print(name , Club.addClub(id=teamId , tournamentId=17 , name=name))


        #getting players of a club
        teamPlayersPath = f'https://api.sofascore.com/api/v1/team/{teamId}/players'
        foundPlayers = json.loads(requests.get(url=teamPlayersPath , headers=header).content)["players"]

        for player in foundPlayers:
            #adding players of a club
            playerId = player["player"]["id"] 
            name = player["player"]["name"]
            position = player["player"]["position"]
            price = random.randint(5 , 12)
            injured = 0

            print(Player.addPlayer(id=playerId , name=name , teamId=teamId , price=price , position=position , injured=injured) , name)


addPlayersToDB()