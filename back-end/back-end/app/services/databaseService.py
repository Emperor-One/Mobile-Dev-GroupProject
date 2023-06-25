from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, Double , ForeignKey , ForeignKeyConstraint
from sqlalchemy.sql.expression import update , desc


path = '..\\main.db'


'''Creating a connection with the database'''
engine = create_engine(f'sqlite:///{path}' , echo=True)
connection = engine.connect()


meta = MetaData()


class User:
    '''CRUD operations on the 'User' table'''
    model = Table(
        "User" , meta,
        Column('id' , Integer , primary_key=True),
        Column('email' , String),
        Column('password' , String),
        Column('age' , Integer , default=18),
        Column('userName' , String)
    )

    @staticmethod
    def createUser(email:str , userName:str , password:str , age:int = 18):
        query = User.model.insert().values(email=email , password=password , age=age , userName=userName)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return e
    
    @staticmethod
    def getUserByEmail(email : str):
        query = User.model.select().where(User.model.c.email == email)
        try:
            fetchedUser = connection.execute(query).fetchone() 
            return {
                "id" : fetchedUser[0],
                "email" : fetchedUser[1],
                "password" : fetchedUser[2],
                "age" : fetchedUser[3],
                "userName" : fetchedUser[4]
            }
        except Exception as e:
            raise e
        
    @staticmethod
    def getUserById(id : int):
        query = User.model.select().where(User.model.c.id == id)
        try:
            return connection.execute(query).fetchone()
        except Exception as e:
            raise e
        
    @staticmethod
    def changePassword(id : int , password : str):
        query = update(User.model).where(User.model.c.id == id).values(password=password)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return e

    @staticmethod
    def changeUserName(userName: str, id: int):
        query = update(User.model).where(User.model.c.id == id).values(userName=userName)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return e
        
    @staticmethod
    def deleteUser(id : int):
        query = User.model.delete().where(User.model.c.id == id)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return e
    
class Match:
    '''CRUD operations on the 'Match' table'''
    model = Table(
        'Match' , meta,
        Column('id' , Integer , primary_key=True),
        Column('home_team' , Integer),
        Column('away_team' , Integer),
        Column('tournament_id' , Integer),
        Column('date' , Integer),
        Column('finished' , Integer),
        Column('elapsed_time' , Integer),
        Column('startTime' , String)
    )
    
    keys = ["id" , "teamIdOne" , "teamIdTwo" , "tournamentId" , "date" , "finished" , "currentState" , "startTime"]

    @staticmethod
    def matchesForDate(date : int):
        query = Match.model.select()
        result = connection.execute(query).fetchall()
        try:
            matches = []
            for match in result:
                matchStat = Match.matchStats(matchId=match[0])
                matchInfo = {key:value for key , value in zip(Match.keys , match)}
                matchInfo['homeScore'] = matchStat["homeStats"]["score"]
                matchInfo['awayScore'] = matchStat["awayStats"]["score"] 
                matchInfo['totShotHome'] = matchStat["homeStats"]["totalShots"]
                matchInfo["totShotAway"] = matchStat["awayStats"]["totalShots"]
                matchInfo["possessionHome"] = matchStat["homeStats"]["possession"]
                matchInfo["possessionAway"] = matchStat["awayStats"]["possession"]
                matchInfo["savesHome"] = matchStat["homeStats"]["saves"]
                matchInfo["savesAway"] = matchStat["awayStats"]["saves"]

                matchInfo['homeTeam'] = Club.getClubName(matchInfo["teamIdOne"])
                matchInfo['awayTeam'] = Club.getClubName(matchInfo["teamIdTwo"])

                
                matches.append(matchInfo)
            return matches
        except Exception as e:
            raise e
    
    @staticmethod
    def matchStats(matchId : int):
        query = Match.model.select().where(Match.model.c.id == matchId)
        try:
            requestedMatch = connection.execute(query).fetchone()

            matchInfo = {key:value for key , value in zip(Match.keys , requestedMatch)} 

            statKeys = ["score" , "possession" , "totalShots" , "shotsOnTarget" , "saves"]
            homeStats = HomeStats.get(matchId=matchId)
            awayStats = AwayStats.get(matchId=matchId)
            
            return {
                **matchInfo,
                'homeStats' : {key:value for key , value in zip(statKeys , homeStats[1:])},
                'awayStats' : {key:value for key , value in zip(statKeys , awayStats[1:])}
            }
        except Exception as e:
            raise e
        
               
class HomeStats:
    '''CRUD operations for the 'Home_Stats' table'''
    model = Table(
        'Home_Stats' , meta,
        Column('match_id' , Integer),
        Column('score' , Integer),
        Column('possession' , Double),
        Column('total_shots' , Integer),
        Column('shots_on_target' , Integer),
        Column('saves' , Integer)
    )
    
    @staticmethod
    def get(matchId : int):
        query = HomeStats.model.select().where(HomeStats.model.c.match_id == matchId)
        try:
            return connection.execute(query).fetchone()
        except Exception as e:
            raise e

class AwayStats:
    '''CRUD operations for the 'Away_Stats' table'''
    model = Table(
        'Away_Stats' , meta,
        Column('match_id' , Integer),
        Column('score' , Integer),
        Column('possession' , Double),
        Column('total_shots' , Integer),
        Column('shots_on_target' , Integer),
        Column('saves' , Integer)
    )

    @staticmethod
    def get(matchId : int):
        query = AwayStats.model.select().where(AwayStats.model.c.match_id == matchId)
        try:
            return connection.execute(query).fetchone()
        except Exception as e:
            raise e    

class Player:
    '''CRUD operations for the 'Player' table'''
    model = Table(
        'Player' , meta,
        Column('id' , Integer , primary_key=True),
        Column('clubId' , Integer),
        Column('name' , String),
        Column('price' , Double),
        Column('position' , String),
        Column('injured' , Integer)
    )

    @staticmethod
    def getPlayer(playerId : int):
        query = Player.model.select().where(Player.model.c.id == playerId)
        try:
            player = connection.execute(query).fetchone() 
            return {
                    "id" : player[0],
                    "clubId" : player[1],
                    "name" : player[2],
                    "price" : player[3],
                    "position" : player[4],
                    "injured" : player[5],              
            }
        except Exception as e:
            raise e 

    @staticmethod
    def getAllPlayers(offset : int = 0 , limit : int = 50):
        query = Player.model.select().offset(offset=offset).limit(limit=limit)
        try:
            players = []
            result = connection.execute(query).fetchall()
            for player in result:
                players.append({
                    "id" : player[0],
                    "clubId" : player[1],
                    "name" : player[2],
                    "price" : player[3],
                    "position" : player[4],
                    "injured" : player[5],
                })
            
            return {
                "success" : True,
                "players" : players
            }
        except Exception as e:
            raise e

    @staticmethod
    def filterPlayers(teamId : int = None , maxPrice : float = float("inf") , minPrice : float = 0 , offset : int = 0 , limit : int = 50):
        if all(x is None for x in (teamId , maxPrice , minPrice)):
            return Player.getAllPlayers(offset=offset , limit=limit)
        elif teamId == None:
            query = Player.model.select().where(Player.model.c.price <= maxPrice , Player.model.c.price >= minPrice).offset(offset=offset).limit(limit=limit)
        elif teamId != None:
            query = Player.model.select().where(Player.model.c.price <= maxPrice , Player.model.c.price >= minPrice , Player.model.c.clubId == teamId).offset(offset=offset).limit(limit=limit)

        try:
            result = connection.execute(query).fetchall()
            players = []
            for player in result:
                players.append({
                    "id" : player[0],
                    "clubId" : player[1],
                    "name" : player[2],
                    "price" : player[3],
                    "position" : player[4],
                    "injured" : player[5],
                })
            
            return {
                "success" : True,
                "players" : players
            }
        except Exception as e:
            raise e

    @staticmethod
    def addPlayer(id : int , name : str , teamId : int , price : int , position : str , injured : int = 0):
        query = Player.model.insert().values(id=id , name=name ,clubId = teamId , price=price , position=position , injured=injured)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return False 

class PlayerStats:
    '''CRUD operations for the 'Player_Stats' table'''
    model = Table(
        'Player_Stats' , meta,
        Column('match_id' , Integer , primary_key=True),
        Column('player_id' , Integer , primary_key=True),
        Column('goals' , Integer),
        Column('assists' , Integer),
        Column('yellow_card' , Integer),
        Column('red_card' , Integer),
        Column('saves' , Integer),
        Column('goals_concided' , Integer),
        Column('minutes_played' , Integer),
        Column('date' , Integer),
        Column('points_gained' , Integer)
    )

    @staticmethod
    def getAllStats(playerId : int):
        query = PlayerStats.model.select().where(PlayerStats.model.c.player_id==playerId).order_by(PlayerStats.model.c.date.desc())
        try:
            result = connection.execute(query).fetchall()
            playerStat = []
            for match in result:
                playerStat.append({
                    "match_id" : match[0],
                    "goals" : match[2],
                    "assists" : match[3],
                    "yellow_card" : match[4],
                    "red_card" : match[5],
                    "saves" : match[6],
                    "goal_concided" : match[7],
                    "minutes_played" : match[8],
                    "date" : match[9],
                    "points_gained" : match[10]
                })
            
            if len(playerStat) == 0:
                return {
                    "match_id" : 0,
                    "goals" : 0,
                    "assists" : 0,
                    "yellow_card" : 0,
                    "red_card" : 0,
                    "saves" : 0,
                    "goal_concided" : 0,
                    "minutes_played" : 0,
                    "date" : 0,
                    "points_gained" : 0
                }
            
            return {
                "id" : playerId,
                "stats" : playerStat
            }
        except Exception as e:
            raise e

    @staticmethod
    def getMatchStats(playerId : int , matchId : int):
        pass

class Club:
    '''CRUD operations for the 'Club' table'''
    model = Table(
        'Club' , meta,
        Column('id' , Integer , primary_key=True),
        Column('tournamentId' , Integer),
        Column('name' , String)
    )

    Keys = ["id" , "tournament_id" , "name"]

    @staticmethod
    def getClubsOfTournament(tournament_id):
        query = Club.model.select().where(Club.model.c.tournamentId == tournament_id)
        try:
            result = []
            clubs = connection.execute(query).fetchall()
            for club in clubs:
                temp = {}
                for key , value in zip(Club.Keys , club):
                    temp[key] = value
                result.append(temp)
            return result
        except Exception as e:
            raise e
        
    @staticmethod
    def addClub(id : int , tournamentId : int , name : str):
        query = Club.model.insert().values(id=id , tournamentId=tournamentId , name=name)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return False
    
    @staticmethod
    def getClubName(id : int):
        query = Club.model.select().where(Club.model.c.id == id)
        try:
            club = connection.execute(query).fetchone()
            return club[2]
        except Exception as e:
            raise e
        
class Tournament:
    model = Table(
        'Tournament' , meta,
        Column('id' , Integer , primary_key=True),
        Column('category' , Integer),
        Column('name' , String)
    )

    Keys = ["id" , "category" , "name"]

    @staticmethod
    def getTournaments():
        query = Tournament.model.select()
        try:
            result = []
            tournaments = connection.execute(query).fetchall()
            for tournament in tournaments:
                temp = {}
                for key , value in zip(Tournament.Keys , tournament):
                    temp[key] = value
            result.append(temp)
            return result 
        except Exception as e:
            raise e 

class Team:
    model = Table(
        'Team' , meta,
        Column('id' , Integer ,  ForeignKey("id", ondelete="CASCADE") ,primary_key=True , autoincrement=True),
        Column('user_id', Integer),
        Column('league_id' , Integer , ForeignKey("Team.id", ondelete="CASCADE")),
        Column('total_points' , Double),
        Column('winner' , Integer),
        Column('money_collected' , Integer),
        Column('date')      
    )
    
    @staticmethod
    def getTeam(teamId : int):
        query = Team.model.select().where(Team.model.c.id == teamId)
        try:
           team = connection.execute(query).fetchone()
           name = User.getUserById(id=team[1])[4]
           return {
                "id" : team[0],
                "name" : name,
                "user_id" : team[1],
                "league_id" : team[2],
                "total_points" : team[3],
                "winner" : team[4],              
           } 
        except Exception as e:
            raise e

    @staticmethod
    def getLeagueTeams(leagueId : int):
        query = Team.model.select().where(Team.model.c.league_id == leagueId).order_by(desc(Team.model.c.total_points))
        try:
            teams = connection.execute(query).fetchall()
            result = []
            for team in teams:
                name = User.getUserById(id=team[1])[4]
                result.append(
                    {
                        "id" : team[0],
                        "user_id" : team[1],
                        "name" : name,
                        "total_points" : team[3],
                        "winner" : team[4],
                    }
                )
            
            return result
        
        except Exception as e:
            raise e
    
    @staticmethod
    def createTeam(userId : int , leagueId : int , date : str):
        query = Team.model.insert().values(user_id = userId , league_id = leagueId , date = date )
        try:
            result = connection.execute(query)
            newTeam = result.inserted_primary_key[0]
            connection.commit()
            return {
                "success" : True,
                "newTeam" : newTeam
            }
        except Exception as e:
            return {
                "success" : False 
            }

    @staticmethod
    def checkUser(leagueId : int , userId : int):
        query = Team.model.select().where(Team.model.c.league_id == leagueId , Team.model.c.user_id == userId)
        try:
            result = connection.execute(query).fetchone()
            if result != None:
                return {
                    "success" : True,
                    "exists" : True
                }
            
            return {
                "success" : True,
                "exists" : False
            }
        
        except Exception as e:
            return {
                "success" : False,
                "error" : e
            }

    @staticmethod
    def deleteTeam(teamId : int):
        query = Team.model.delete().where(Team.model.c.id == teamId)
        try:
            #delete the user from admin table if present
            requestedTeam = Team.getTeam(teamId=teamId)
            LeagueAdmin.removeAdmin(leagueId=requestedTeam["league_id"] , userId=requestedTeam["user_id"])

            #deleting team from league 
            connection.execute(query)
            connection.commit()
            
            #deleting the players of the team
            TeamPlayers.deletePlayersOfTeam(teamId=teamId)

            return True
        except Exception as e:
            return e
    
    @staticmethod
    def deleteTeamsFromLeague(leagueId : int):
        try: 
            #get all teams from league
            teams = League.getTeams(leagueId=leagueId)
            #delete all teams
            for team in teams:
                Team.deleteTeam(teamId=team["id"])
            return True
        
        except Exception as e:
            raise e

    @staticmethod
    def getTeamsOfUser(userId : int):
        query = Team.model.select().where(Team.model.c.user_id==userId)
        try:
            teams = connection.execute(query).fetchall()
            result = []
            for team in teams:
                temp = {
                        "teamId" : team[0],
                        "userId" : team[1],
                        "leagueId" : team[2],
                        "totalPoints" : team[3],
                        "winner" : team[4],
                        "moneyCollected" : team[5],
                        "date" : team[6]
                    }
                try:
                    league = League.getLeague(leagueId=temp["leagueId"])
                
                    if league["league"]["owner"] == temp["userId"]:
                        temp["owner"] = True
                    else:
                        temp["owner"] = False
                    
                    checkAdmin = LeagueAdmin.checkAdmin(leagueId=temp["leagueId"] , userId=userId)
                    temp["admin"] = False if checkAdmin != True else True 
                    temp["leagueName"] = league["league"]["name"]
                    result.append(temp)
                except: 
                    continue

            return {
                "success" : True,
                "teams" : result
            }
        except Exception as e:
            raise e
                
class TeamPlayers:
    model = Table(
        'Team_Players' , meta,
        Column('team_id' , Integer , ForeignKey("Team_Players.team_id", ondelete="CASCADE")),
        Column('player_id' , Integer),
        Column('captain' , Integer),
        Column('reserve' , Integer)
    )

    @staticmethod
    def addPlayerToTeam(teamId : int , playerId : int , captain : int = 0 , reserve : int = 0):
        query = TeamPlayers.model.insert().values(team_id = teamId  , player_id = playerId , captain = captain , reserve = reserve)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            return e
    
    @staticmethod
    def deletePlayersOfTeam(teamId : int):
        query = TeamPlayers.model.delete().where(TeamPlayers.model.c.team_id == teamId)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            raise e

    @staticmethod
    def getTeamPlayers(teamId : int):
        query = TeamPlayers.model.select().where(TeamPlayers.model.c.team_id == teamId)
        try:
            result = connection.execute(query).fetchall()
            players = []
            for player in result:
                playerName = Player.getPlayer(playerId=player[1])
                players.append(
                    {
                        "teamId" : player[0],
                        "playerId" : player[1],
                        "captain" : player[2],
                        "reserve" : player[3],
                        "name" : playerName["name"]
                    }
                )
            
            return players
        except Exception as e:
            raise e
        
class League:
    model = Table(
        'League' , meta,
        Column('id' , Integer , ForeignKey("league.id", ondelete="CASCADE") , primary_key=True , autoincrement=True),
        Column('owner' , Integer),
        Column('tournament_id' , Integer),
        Column('name' , String),
        Column('entry_fee' , Double),
        Column('private' , Integer),
        Column('entry_code' , String),
        Column('date' , String),
        Column('prize_pool' , Double)
        )

    keys = ["id" , "tournamentId" , "name" , "entryFee" , "private" , "entry_code" , "date" , "prize_pool"]

    @staticmethod
    def createLeague(owner : int , tournament_id : int , name : str , date : str , entry_code : str = '' , private : int = 0 , entry_fee : float = 0.0):
        query = League.model.insert().values(owner = owner , tournament_id = tournament_id , name = name , entry_fee = entry_fee , private = private , entry_code = entry_code , date = date)
        try:
            result = connection.execute(query)
            newLeague = result.inserted_primary_key[0]
            connection.commit()
            return {
                "success" : True,
                "newLeague" : newLeague    
                }
        except Exception as e:
            return {
                "success" : False
            }

    @staticmethod
    def getPublicLeagues():
        query = League.model.select().where(League.model.c.private == 0)
        try:
            leagues = connection.execute(query).fetchall()
            result = []
            for league in leagues:
                result.append({
                    "id" : league[0],
                    "owner" : league[1],
                    "tournamentId" : league[2],
                    "name" : league[3],
                    "entryFee" : league[4],
                    "date" : league[7],
                    "prizePool" : league[8]
                })
            return result
        except Exception as e:
            raise e

    @staticmethod
    def getLeague(leagueId : int):
        query = League.model.select().where(League.model.c.id == leagueId)
        try:
            league = connection.execute(query).fetchone()
            result = {
                    "id" : league[0],
                    "owner" : league[1],
                    "private" : league[5],
                    "entryCode" : league[6],
                    "tournamentId" : league[2],
                    "name" : league[3],
                    "entryFee" : league[4],
                    "date" : league[7],
                    "prizePool" : league[8]
                }
            return {
                "success" : True,
                "league" : result 
            }
        except Exception as e:
            raise e

    @staticmethod
    def getTeams(leagueId : int):
        return Team.getLeagueTeams(leagueId=leagueId)
    
    @staticmethod
    def checkForUser(leagueId : int , userId : int):
        return Team.checkUser(leagueId=leagueId , userId=userId)
    
    @staticmethod
    def deleteLeague(leagueId : int):
        query = League.model.delete().where(League.model.c.id == leagueId)
        try:
            connection.execute(query)
            connection.commit()
            #delete all the teams
            Team.deleteTeamsFromLeague(leagueId=leagueId)
            return True
        except Exception as e:
            return e
    
    @staticmethod
    def checkOwner(leagueId : int , userId : int):
        try:
            league = League.getLeague(leagueId=leagueId)["league"]
            if league["owner"]==userId:
                return True            
            return False
        except Exception as e:
            raise e

    @staticmethod
    def updateName(leagueId : int , newName : str):
        query = update(League.model).where(League.model.c.id == leagueId).values(name=newName)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            raise e

class LeagueAdmin:
    model = Table(
        'League_Admin' , meta,
        Column("league_id" , Integer),
        Column("user_id" , Integer)
    )

    @staticmethod
    def getAdmins(leagueId : int):
        query = LeagueAdmin.model.select().where(LeagueAdmin.model.c.league_id==leagueId)
        try:
            admins = connection.execute(query).fetchall()
            result = []
            for admin in admins:
                result.append({
                    "leagueId" : admin[0],
                    "userId" : admin[1]
                })
            
            return{
                "success" : True,
                "admins" : result
            }
        except Exception as e:
            raise e

    @staticmethod
    def removeAdmin(leagueId : int , userId: int):
        query = LeagueAdmin.model.delete().where(LeagueAdmin.model.c.league_id==leagueId , LeagueAdmin.model.c.user_id==userId)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            raise e

    @staticmethod
    def makeAdmin(leagueId : int , userId : int):
        query = LeagueAdmin.model.insert().values(league_id=leagueId , user_id=userId)
        try:
            connection.execute(query)
            connection.commit()
            return True
        except Exception as e:
            raise e

    @staticmethod
    def checkAdmin(leagueId : int , userId : int):
        try:
            admins = LeagueAdmin.getAdmins(leagueId=leagueId)["admins"]
            for admin in admins:
                if admin["userId"] == userId:
                    return True
                else:
                    return False
        except Exception as e:
            raise e


#Simple tests
if __name__ == '__main__':
    '''
    print('########')
    print(User.getUserByEmail('test@gmail.com'))
    print('########')
    print(Match.matchesForDate(date=1679727600))
    print('########')
    print(Match.matchStats(matchId=1))
    print('########')
    print(Tournament.getTournaments())
    print('########')
    print('########')
    print(League.getPublicLeagues())
    print('########')
    #print(League.createLeague(owner=1 , tournament_id=1 , name="Test-League" , date=1000 , private=0 , entry_fee=6))
    print('########')
    #print(League.getPublicLeagues())
    print('########')
    print(Player.getPlayer(playerId=2))
    print(League.getLeague(leagueId=6))
    print(Team.getTeam(teamId=2))
    print(TeamPlayers.deletePlayersOfTeam(teamId=6))
    print(Team.deleteTeamsFromLeague(leagueId=10))
    print(Player.getAllPlayers())
    print(Player.filterPlayers(maxPrice=4))
    print(LeagueAdmin.makeAdmin(leagueId=6 , userId=2))
    print(LeagueAdmin.getAdmins(leagueId=6))
    print(LeagueAdmin.removeAdmin(leagueId=6 , userId=2))
    print(LeagueAdmin.getAdmins(leagueId=6))
    print(Player.addPlayer(234 , 'name' , teamId=1 , price=90 , position='w' , injured=0))
    '''
    print(TeamPlayers.getTeamPlayers(teamId=1))
    pass