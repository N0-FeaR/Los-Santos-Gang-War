//============================================================================//
//================// Los Santos Gangwar(TDM) //================//
//============================================================================//
//===============================// Credits //================================// Do not remove credits...
//= N0FeaR - Gamemode creator
//= Y_Less - Sscanf2, Y_ini
//= Zeex - ZCMD
//= Incognito - Streamer
#define NO_TAGS
#pragma warning disable 213

#include <open.mp>
#include <YSI\YSI_Storage\y_ini>
#include <sscanf2>
#include <zcmd>


#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define PATH "/Users/%s.ini"
//Color
#define COL_WHITE "{FFFFFF}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_VIP 0xD200D2FF
#define COLOR_PM 0xDFDF00FF
//Teams
#define TEAM_GROVE 1
#define TEAM_COPS 2
#define TEAM_VAGOS 3
#define TEAM_BALLAS 4
#define TEAM_GROVE_COLOR 0x00FF00AA
#define TEAM_COPS_COLOR 0x4169FFAA
#define TEAM_VAGOS_COLOR 0xDABB3EAA
#define TEAM_BALLAS_COLOR 0xC2A2DAAA
//Dialogs
#define DIALOG_SHOP 999
#define DIALOG_HELP 998
#define DIALOG_TUT 997
#define DIALOG_USELESS 996
#define DIALOG_CSHOP 995

enum pInfo //Player info enum
{
    pPass,
    pCash,
    pVip,
    pTogVC,
    pAdmin,
    pKills,
    pDeaths,
	pBanned,
	pWarns,
	pReportMuted,
	pCookies,
	pWeapon[6]
}

new gTeam[MAX_PLAYERS];
new PlayerInfo[MAX_PLAYERS][pInfo];
new copcar[5];
new grovecar[5];
new vagoscar[5];
new ballascar[5];
new     Text:Textdraw50,
        Text:Textdraw51,
        Text:Textdraw52,
        Text:Textdraw53,
        Text:Textdraw54,
		Text:LableDraw[MAX_PLAYERS],
		Text:UsedDraw[MAX_PLAYERS];
new Dead[MAX_PLAYERS], Killedby[MAX_PLAYERS];
new RandomMSG[][] =
{
    "Regsiter on our forum (forum link here)",
    "If someone break the rules simply use /report",
    "Need help? use /help or just /helpme"
};

forward LoadUser_data(playerid,name[],value[]); 
forward ABroadCast(color,const string[],level); 
forward VBroadCast(color,const string[],level);
forward KillCam(playerid);
forward SendMSG();
forward CopCar(carid);
forward GroveCar(carid);
forward VagosCar(carid);
forward BallasCar(carid);

//==============================================MAIN SCRIPT========================================================

main()
{
	print("\n----------------------------------");
	print(" Los Santos Gangwar by N0FeaR");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("LSGW V1.0");
	SendRconCommand("mapname Los Santos");
	ShowNameTags(1);
	SetWorldTime(0);
	ShowPlayerMarkers(1);
	DisableInteriorEnterExits();


	//Grove street skins
	AddPlayerClass(105,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,4,1);
	AddPlayerClass(106,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,5,1);
	AddPlayerClass(107,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20001,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20002,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20003,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20004,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20005,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20006,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20007,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	AddPlayerClass(20008,2513.1086,-1674.1039,13.5250,81.5817,22,51,32,300,1,1);
	//Police skin
	AddPlayerClass(280,1579.2726,-1696.2872,6.2188,178.3626,22,170,29,300,0,0);
	AddPlayerClass(281,1579.2726,-1696.2872,6.2188,178.3626,22,170,29,300,0,0);
	AddPlayerClass(282,1579.2726,-1696.2872,6.2188,178.3626,22,170,29,300,0,0);
	AddPlayerClass(285,1579.2726,-1696.2872,6.2188,178.3626,25,20,28,300,0,0);
	//Vagos skin
	AddPlayerClass(108,2352.2170,-1166.7721,27.5047,0.0509,22,51,32,300,4,1);
	AddPlayerClass(109,2352.2170,-1166.7721,27.5047,0.0509,22,51,32,300,5,1);
	AddPlayerClass(110,2352.2170,-1166.7721,27.5047,0.0509,22,51,32,300,1,1);
	//Ballas skin
	AddPlayerClass(102,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,4,1);
	AddPlayerClass(103,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,5,1);
	AddPlayerClass(104,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20009,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20010,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20011,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20012,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20013,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20014,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20015,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20016,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20017,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	AddPlayerClass(20018,1928.9652,-1127.3171,25.2060,180.8459,22,51,32,300,1,1);
	
	
	ballascar[0] = AddStaticVehicleEx(566,1951.9005000,-1130.7524000,25.1931000,270.7987000,22,22,90000); //Ballas car
	ballascar[1] = AddStaticVehicleEx(566,1944.8051000,-1130.9333000,25.1931000,270.7987000,22,22,90000); //Ballas car
	ballascar[2] = AddStaticVehicleEx(566,1937.3132000,-1130.8268000,25.1931000,271.3987000,22,22,90000); //Ballas car
	ballascar[3] = AddStaticVehicleEx(566,1929.6244000,-1130.8729000,25.1931000,271.3387000,22,22,90000); //Ballas car
	
	
	vagoscar[0] = AddStaticVehicleEx(576,2352.2798000,-1159.2941000,26.9767000,269.5949000,6,6,90000); //Vagos car
	vagoscar[1] = AddStaticVehicleEx(576,2344.3250000,-1159.1376000,26.9767000,269.5949000,6,6,90000); //Vagos car
	vagoscar[2] = AddStaticVehicleEx(576,2335.8003000,-1158.9678000,26.9767000,269.5949000,6,6,90000); //Vagos car
	vagoscar[3] = AddStaticVehicleEx(576,2327.1885000,-1158.9600000,26.9767000,269.5949000,6,6,90000); //Vagos car
	
	grovecar[0] = AddStaticVehicleEx(567,2492.4133000,-1684.3237000,13.1573000,269.6195000,86,86,90000); //Grove car
	grovecar[1] = AddStaticVehicleEx(567,2484.6973000,-1684.4308000,13.1573000,269.6195000,86,86,90000); //Grove car
	grovecar[2] = AddStaticVehicleEx(565,2508.8499000,-1672.0002000,12.7691000,0.0000000,86,86,90000); //Grove car
	
	copcar[0] = AddStaticVehicleEx(596,1574.4238000,-1709.9728000,5.3926000,0.2989000,-1,-1,90000); //Police Car (LSPD)
	copcar[1] = AddStaticVehicleEx(596,1578.5587000,-1710.1501000,5.3926000,0.2989000,-1,-1,90000); //Police Car (LSPD)
	copcar[2] = AddStaticVehicleEx(596,1583.2664000,-1710.0103000,5.3926000,0.2989000,-1,-1,90000); //Police Car (LSPD)
	copcar[3] = AddStaticVehicleEx(596,1587.4918000,-1710.1576000,5.3926000,0.2989000,-1,-1,90000); //Police Car (LSPD)
	
	//Plate
	SetVehicleNumberPlate(grovecar[0], "Grove Street");
	SetVehicleNumberPlate(grovecar[1], "Grove Street");
	SetVehicleNumberPlate(grovecar[2], "Grove Street");
	SetVehicleNumberPlate(vagoscar[0], "Vagos");
	SetVehicleNumberPlate(vagoscar[1], "Vagos");
	SetVehicleNumberPlate(vagoscar[2], "Vagos");
	SetVehicleNumberPlate(vagoscar[3], "Vagos");
	SetVehicleNumberPlate(ballascar[1], "Ballas");
	SetVehicleNumberPlate(ballascar[2], "Ballas");
	SetVehicleNumberPlate(ballascar[0], "Ballas");
	SetVehicleNumberPlate(ballascar[1], "Ballas");
	SetVehicleNumberPlate(copcar[0], "Police");
	SetVehicleNumberPlate(copcar[1], "Police");
	SetVehicleNumberPlate(copcar[2], "Police");
	SetVehicleNumberPlate(copcar[3], "Police");
	
	//Mods to vehicle
	AddVehicleComponent(grovecar[0], 1010); // Nitro
	
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		UsedDraw[i] = TextDrawCreate(1.000000,1.000000," ");
		LableDraw[i] = TextDrawCreate(456.000000,160.000000," ");
		TextDrawAlignment(LableDraw[i],0);
		TextDrawBackgroundColor(LableDraw[i],0x000000ff);
		TextDrawFont(LableDraw[i],0);
		TextDrawLetterSize(LableDraw[i],1.000000,1.900000);
		TextDrawColor(LableDraw[i],0xffffffff);
		TextDrawSetOutline(LableDraw[i],1);
		TextDrawSetProportional(LableDraw[i],1);
		TextDrawSetShadow(LableDraw[i],1);
	}
	
	
 	Textdraw50 = TextDrawCreate(0.000000, 0.000000, "LD_SPAC:white");           // Kill-cam (by N0FeaR)
	TextDrawLetterSize(Textdraw50, 0.000000, 0.000000);
 	TextDrawTextSize(Textdraw50, 640.000000, 59.920001);
 	TextDrawAlignment(Textdraw50, 1);
 	TextDrawColour(Textdraw50, 255);
 	TextDrawSetShadow(Textdraw50, 0);
 	TextDrawSetOutline(Textdraw50, 0);
 	TextDrawFont(Textdraw50, 4);
 	Textdraw51 = TextDrawCreate(641.500000, 61.420001, "usebox");
  	TextDrawLetterSize(Textdraw51, 0.000000, 42.741107);
   	TextDrawTextSize(Textdraw51, -2.000000, 0.000000);
    TextDrawAlignment(Textdraw51, 1);
    TextDrawColour(Textdraw51, 0);
    TextDrawUseBox(Textdraw51, true);
    TextDrawBoxColor(Textdraw51, 102);
    TextDrawSetShadow(Textdraw51, 0);
    TextDrawSetOutline(Textdraw51, 0);
    TextDrawFont(Textdraw51, 0);
    Textdraw52 = TextDrawCreate(0.000000, 423.920013, "LD_SPAC:white");
    TextDrawLetterSize(Textdraw52, 0.000000, 0.000000);
    TextDrawTextSize(Textdraw52, 640.000000, 19.600006);
    TextDrawAlignment(Textdraw52, 1);
    TextDrawColour(Textdraw52, 255);
    TextDrawSetShadow(Textdraw52, 0);
    TextDrawSetOutline(Textdraw52, 0);
    TextDrawFont(Textdraw52, 4);
    Textdraw53 = TextDrawCreate(246.000000, 11.760004, "KILL - CAM");
    TextDrawLetterSize(Textdraw53, 0.784999, 3.644000);
    TextDrawAlignment(Textdraw53, 1);
    TextDrawColour(Textdraw53, -1378294017);
    TextDrawSetShadow(Textdraw53, 0);
    TextDrawSetOutline(Textdraw53, 1);
    TextDrawBackgroundColor(Textdraw53, 51);
    TextDrawFont(Textdraw53, 3);
    TextDrawSetProportional(Textdraw53, 1);
    Textdraw54 = TextDrawCreate(54.500000, 425.599914, "Spawn in five seconds.");
    TextDrawLetterSize(Textdraw54, 0.350500, 1.488000);
    TextDrawAlignment(Textdraw54, 1);
    TextDrawColour(Textdraw54, -1378294017);
    TextDrawSetShadow(Textdraw54, 0);
    TextDrawSetOutline(Textdraw54, 1);
    TextDrawBackgroundColor(Textdraw54, 51);
    TextDrawFont(Textdraw54, 1);
    TextDrawSetProportional(Textdraw54, 1);
    SetTimer("SendMSG",180000,1); // each 3min

	return 1;
}
public SendMSG()
{
    new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(COLOR_LIGHTBLUE, RandomMSG[randMSG]);
}
public KillCam(playerid)
{
 	TogglePlayerSpectating(playerid, 0);
  	TextDrawHideForPlayer(playerid, Textdraw50), TextDrawHideForPlayer(playerid, Textdraw51),
	TextDrawHideForPlayer(playerid, Textdraw52), TextDrawHideForPlayer(playerid, Textdraw53),
	TextDrawHideForPlayer(playerid, Textdraw54);
}
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 259.2184,-41.4297,1002.0234);
	SetPlayerFacingAngle(playerid, 89.9766);
	SetPlayerInterior(playerid, 14);
	SetPlayerCameraPos(playerid, 254.9213,-39.8146,1002.0234);
	SetPlayerCameraLookAt(playerid, 259.2184,-41.4297,1002.0234);
	SetPlayerTeamFromClass(playerid, classid);
 	switch (classid)
  	{
   		case 0,1,2,3,4,5,6,7,8,9,10,11://GROVE
     	{
     		if(classid == 0 || classid == 1 || classid == 2 || classid == 3 || classid == 4 || classid == 5 || classid == 6 || classid == 7 || classid == 8 || classid == 9 || classid == 10 || classid == 11)
       		{
				//GameTextForPlayer(playerid,"~g~Grove Street",800,6);
				CreateLableText(playerid,"Grove Street");
				
			}
		}
        case 12,13,14,15://LSPD
        {
        	if(classid == 12 || classid == 13 || classid == 14 || classid == 15)
            {
            	GameTextForPlayer(playerid,"~b~LSPD",800,6);
         	}
         }
         case 16,17,18://VAGOS
         {
         	if(classid == 16 || classid == 17 || classid == 18)
          	{
            	GameTextForPlayer(playerid,"~y~Vagos",800,6);
       		}
         }
         case 19,20,21,22,23,24,25,26,27,28,29,30,31://BALLAS
         {
			if(classid == 19 || classid == 20 || classid == 22 || classid == 23 || classid == 24 || classid == 25 || classid == 26 || classid == 27 || classid == 28 || classid == 29 || classid == 30 || classid == 31)
			{
				GameTextForPlayer(playerid,"~p~Ballas",800,6);
			}
		}
   	}
	return 1;
}
public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid, 0, 1552.9211, -1675.8593, 15.7289, 30, 0, MAPICON_GLOBAL); //LSPD icon
    SetPlayerMapIcon(playerid, 1, 2490.8176, -1671.7831, 13.0343, 62, 0, MAPICON_GLOBAL); //Grove icon
    SetPlayerMapIcon(playerid, 2, 1944.0792, -1134.9735, 25.1706, 59, 0, MAPICON_GLOBAL); //Ballas icon
    SetPlayerMapIcon(playerid, 3, 2353.1553, -1164.3435, 27.1711, 60, 0, MAPICON_GLOBAL); //Vagos icon
    SendClientMessage(playerid, COLOR_WHITE, "Welcome to Los Santos Gangwar!");
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_WHITE"Type your password below to login.","Login","Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,""COL_WHITE"Registering...",""COL_WHITE"Type your password below to register your account.","Register","Quit");
    }
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
// antiteamkill_
	new Float:Health;
    GetPlayerHealth(playerid, Health);
	if(gTeam[issuerid] == gTeam[playerid])
 	{
    	GetPlayerHealth(playerid, Health);
     	SetPlayerHealth(playerid, Health+amount);
    }
// damageinfo_
    if(issuerid != INVALID_PLAYER_ID)
    {
        new string[128];
        format(string, sizeof(string), "~b~+%.0f ~w~dammage", amount);
        GameTextForPlayer(issuerid, string, 5000, 1);
        PlayerPlaySound(issuerid, 1057, 0.0, 0.0, 0.0);

        format(string, sizeof(string), "~r~-%.0f ~w~dammage", amount);
        GameTextForPlayer(playerid, string, 5000, 1);
        PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new killerscore = GetPlayerScore(killerid);
	if (gTeam[playerid] == gTeam[killerid])
	{
		SetPlayerScore(killerid, killerscore-1);
		GivePlayerMoney(killerid, -500);
		GivePlayerMoney(playerid, 500);
		SendClientMessage(playerid, COLOR_WHITE, "Compensation for being teamkilled: $500!");
	}
	else SetPlayerScore(killerid, killerscore+1);
	GivePlayerMoney(killerid, 500);
	GivePlayerMoney(playerid, -500);
	PlayerInfo[killerid][pKills]++;
    PlayerInfo[playerid][pDeaths]++;
	SendDeathMessage(killerid,playerid,reason);
    Dead[playerid] = 1;
    if(Dead[playerid] == 1)
    {
        Dead[playerid] = 0;
        if(Killedby[playerid] != INVALID_PLAYER_ID)
        TogglePlayerSpectating(playerid, 1);
        PlayerSpectatePlayer(playerid, killerid);
        TextDrawShowForPlayer(playerid, Textdraw50), TextDrawShowForPlayer(playerid, Textdraw51),
        TextDrawShowForPlayer(playerid, Textdraw52), TextDrawShowForPlayer(playerid, Textdraw53),
        TextDrawShowForPlayer(playerid, Textdraw54);
        SetTimerEx("KillCam", 5000, false, "i", playerid);
    }
    else
    {
        TogglePlayerSpectating(playerid, 0);
    }
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
 return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
        new newcar = GetPlayerVehicleID(playerid);
		if(CopCar(newcar))
		{
 			if (gTeam[playerid] == TEAM_COPS)
			{
				}
  				else
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You're not in the Police team");
			}
		}
		else if(GroveCar(newcar))
		{
 			if (gTeam[playerid] == TEAM_GROVE)
			{
				}
  				else
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You're not in the Grove Street team");
			}
		}
		else if(VagosCar(newcar))
		{
 			if (gTeam[playerid] == TEAM_VAGOS)
			{
				}
  				else
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You're not in the Vagos team");
			}
		}
		else if(BallasCar(newcar))
		{
 			if (gTeam[playerid] == TEAM_BALLAS)
			{
				}
  				else
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You're not in the Ballas team");
			}
		}
	}
    return 1;
}
public OnPlayerSpawn(playerid)
{
    StopAudioStreamForPlayer(playerid);
    SetPlayerInterior(playerid, 0);
    SetPlayerToTeamColor(playerid);
    DeletePVar(playerid, "LableDraw");
	SendClientMessage(playerid, COLOR_WHITE, "A shop is available! To access it, type /shop!");
	if(PlayerInfo[playerid][pVip] == 1) return SetPlayerArmour(playerid, 50);
	if(PlayerInfo[playerid][pVip] == 2) return SetPlayerArmour(playerid, 100);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data"); 
    INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_WriteInt(File,"VIP",PlayerInfo[playerid][pVip]);
    INI_WriteInt(File,"Banned",PlayerInfo[playerid][pBanned]);
    INI_WriteInt(File,"Warnings",PlayerInfo[playerid][pWarns]);
    INI_WriteInt(File,"Reportmute",PlayerInfo[playerid][pReportMuted]);
    INI_WriteInt(File,"Cookies",PlayerInfo[playerid][pCookies]);
    INI_WriteInt(File,"VC",0);
    INI_WriteInt(File,"Weapon0",PlayerInfo[playerid][pWeapon][0]);
    INI_WriteInt(File,"Weapon1",PlayerInfo[playerid][pWeapon][1]);
    INI_WriteInt(File,"Weapon2",PlayerInfo[playerid][pWeapon][2]);
    INI_WriteInt(File,"Weapon3",PlayerInfo[playerid][pWeapon][3]);
    INI_WriteInt(File,"Weapon4",PlayerInfo[playerid][pWeapon][4]);
    INI_WriteInt(File,"Weapon5",PlayerInfo[playerid][pWeapon][5]);
    INI_Close(File);
    return 1;
}
public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
{
    new veh = GetPlayerVehicleID(playerid);
    new Float:x,Float:y,Float:z; //= GetPlayerPos(playerid,x,y,z);
    SetPlayerArmedWeapon(playerid, 0);
    for(new i;i<MAX_PLAYERS<i++;)
    {
        if(IsPlayerInVehicle(i,veh) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
        {
            if(GetPlayerTeam(i) == GetPlayerTeam(playerid))
            {
                SetPlayerPos(playerid,x,y,z+2);
                GameTextForPlayer(playerid,"~r~ANTI-TEAM JACK", 2000,4);
            }
        }
    }
    return 1;
}


SetPlayerTeamFromClass(playerid, classid)
{
    // Apply animation outside of the switch statement
    ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);

    // Determine player's team based on class id
    if (classid >= 0 && classid <= 11)
    {
        gTeam[playerid] = TEAM_GROVE;
    }
    else if (classid >= 12 && classid <= 15)
    {
        gTeam[playerid] = TEAM_COPS;
    }
    else if (classid >= 16 && classid <= 18)
    {
        gTeam[playerid] = TEAM_VAGOS;
    }
    else if (classid >= 19 && classid <= 31)
    {
        gTeam[playerid] = TEAM_BALLAS;
    }
    else
    {
        // Handle invalid class id if needed
    }

    return 1;
}
SetPlayerToTeamColor(playerid)
{
	if (gTeam[playerid] == TEAM_GROVE)
	{
		SetPlayerColor(playerid, TEAM_GROVE_COLOR);
	}
	else if (gTeam[playerid] == TEAM_COPS)
	{
		SetPlayerColor(playerid, TEAM_COPS_COLOR);
	}
	else if (gTeam[playerid] == TEAM_VAGOS)
	{
		SetPlayerColor(playerid, TEAM_VAGOS_COLOR);
	}
	else if (gTeam[playerid] == TEAM_BALLAS)
	{
		SetPlayerColor(playerid, TEAM_BALLAS_COLOR);
	}
}
	new SERVER_DOWNLOAD[] = "https://media.rg-rp.net/gangwar";
	public OnPlayerRequestDownload(playerid, type, crc)
 	{
  		if(!IsPlayerConnected(playerid))
    		return 0;

		new filename[64], filefound, final_url[256];

		if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
  			filefound = FindTextureFileNameFromCRC(crc, filename, sizeof(filename));
     	else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
      		filefound = FindModelFileNameFromCRC(crc, filename, sizeof(filename));

		if(filefound)
  		{
    		format(final_url, sizeof(final_url), "%s/%s", SERVER_DOWNLOAD, filename);
   			RedirectDownload(playerid, final_url);
  		}
    	return 1;
	}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        
	switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Type your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"VIP",0);
                INI_WriteInt(File,"Banned",0);
                INI_WriteInt(File,"Warnings",0);
				INI_WriteInt(File,"Reportmute",0);
				INI_WriteInt(File,"Cookies",0);
				INI_WriteInt(File,"VC",0);
				INI_WriteInt(File,"Weapon",0);
                INI_Close(File);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,""COL_WHITE"Success!",""COL_GREEN"Relog to save your stats!","Ok","");
                GivePlayerMoney(playerid, 15000);
                SendClientMessage(playerid, COLOR_WHITE, "Welcome to Los Santos Gangwar! Now you'll proceed to tutorial.");
                ShowPlayerDialog(playerid, DIALOG_TUT, DIALOG_STYLE_MSGBOX,""COL_WHITE"Tutorial","{00FF22}1.Rules\n{FFFFFF}1.Respect all players and admins\n2.Never abuse bugs or get BANNED.\n3.Don't be rude or get warned and/or kicked\n4.Abusing /report will get you warned and muted from reports\n{00FF22}2.Help\n{FFFFFF}If you need to know which CMD's this server includes, you always can use /help. For any other help, use /report","Thanks","");
            }
        }

        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
                    ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_MSGBOX,""COL_WHITE"Success!",""COL_GREEN"You have successfully logged in!","Ok","");
					DeletePVar(playerid,"LableDraw");
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,"Login", "Type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
    }
	if(dialogid == DIALOG_HELP)
	{
        if(!response) return SendClientMessage(playerid, COLOR_WHITE, "The action is canceled!");
		switch(listitem)
		{
			case 0: // Player commands
			{
			 	ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:PLAYER COMMANDS:.","/stats, /shop, /kill, /report, /pm, /changeteam","OK","");
				return 1;
			}
			case 1: // Admin commands
			{
			    if(PlayerInfo[playerid][pAdmin]==0) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","You are not an Admin!","OK","");
				if(PlayerInfo[playerid][pAdmin]==1) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","/kick, /warn","OK","");
				if(PlayerInfo[playerid][pAdmin]==2) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","/kick, /sethealth, /setarmour, /fine /warn, /reportmute, /goto\n/gethere","OK","");
				if(PlayerInfo[playerid][pAdmin]==3) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","/ban, /unban, /givecash, /kick, /sethealth, /setarmour, /fine\n /warn, /reportmute, /goto, /gethere","OK","");
				if(PlayerInfo[playerid][pAdmin]==4) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","/ban, /unban, /givecash, /kick, /sethealth, /setarmour, /fine\n /warn, /reportmute, /goto, /gethere, /givecookie","OK","");
				if(PlayerInfo[playerid][pAdmin]==5) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:ADMIN COMMANDS:.","/ban, /unban, /givecash, /kick, /sethealth, /setarmour, /fine\n /warn, /reportmute, /goto, /gethere, /makevip, /makeadmin, /resetstats\n/givecookie ","OK","");
				return 1;
			}
			case 2: // VIP commands
			{
                if(PlayerInfo[playerid][pVip]==0) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:VIP COMMANDS:.","You are not a VIP!","OK","");
				if(PlayerInfo[playerid][pVip]==1) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:VIP COMMANDS:.","/vc, /togvc","OK","");
				if(PlayerInfo[playerid][pVip]==2) return ShowPlayerDialog(playerid, DIALOG_USELESS, DIALOG_STYLE_MSGBOX,""COL_WHITE".:VIP COMMANDS:.","/vc, /togvc","OK","");
				return 1;
			}
		 }
	}
	if(dialogid == DIALOG_SHOP) // Shop dialog
	{
        if(!response) return SendClientMessage(playerid, COLOR_WHITE, "The action is canceled!");
		switch(listitem)
		{
			case 0: // Deagle
			{
				if (GetPlayerMoney(playerid)>=10000)
				{
	    			SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought a deagle!");
					GivePlayerWeapon(playerid, 24, 100000);
					GivePlayerMoney(playerid, -10000);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money!");
				return 1;
			}
			case 1: // AK
			{
				if (GetPlayerMoney(playerid)>=15000)
				{
 					SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought AK!");
					GivePlayerWeapon(playerid, 30, 100000);
					GivePlayerMoney(playerid, -15000);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money!");
				return 1;
			}
			case 2: // Grenade
			{
			    if(PlayerInfo[playerid][pVip]>=1)
			    {
					if (GetPlayerMoney(playerid)>=10000)
					{
 						SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought one grenade!");
						GivePlayerWeapon(playerid, 16, 1);
						GivePlayerMoney(playerid, -10000);
						return 1;
					}
					else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money!");
					return 1;
				}
				else SendClientMessage(playerid, COLOR_RED, "You must be at least VIP to buy a grenade!");
			}
			case 3: // Health
			{
				if (GetPlayerMoney(playerid)>=2500)
				{
					SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought first aid kit!");
					SetPlayerHealth(playerid, 100);
					GivePlayerMoney(playerid, -2500);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money!");
				return 1;
			}
			case 4: // Armour
			{
				if (GetPlayerMoney(playerid)>=5000)
				{
 					SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought armour!");
					SetPlayerArmour(playerid, 100);
					GivePlayerMoney(playerid, -5000);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money!");
				return 1;
			}
        }
	}
	if(dialogid == DIALOG_CSHOP) // Cookie shop dialog
	{
        if(!response) return SendClientMessage(playerid, COLOR_WHITE, "The action is canceled!");
		switch(listitem)
		{
			case 0: // Armour
			{
				if (PlayerInfo[playerid][pCookies] >= 2)
				{
	    			SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought armour!");
					PlayerInfo[playerid][pCookies] = PlayerInfo[playerid][pCookies]-2;
					SetPlayerArmour(playerid, 100);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough cookies!");
				return 1;
			}
			case 1: // AK
			{
				if (PlayerInfo[playerid][pCookies] >= 5)
				{
	    			SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully bought AK!");
					PlayerInfo[playerid][pCookies] = PlayerInfo[playerid][pCookies]-5;
					GivePlayerWeapon(playerid, 30, 99999);
					return 1;
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You don't have enough cookies!");
				return 1;
			}
		}
	}
	return 1;
}

//=====================================================Commands==================================================

// Regular Players CMD's section
CMD:changeteam(playerid) // CMD for calling a change team
{
    SetPlayerHealth(playerid, 0.0);
    ForceClassSelection(playerid);
    return 1;
}


CMD:shop(playerid) // CMD for calling a shop
{
    ShowPlayerDialog(playerid, DIALOG_SHOP, DIALOG_STYLE_LIST, "Shop", "Deagle ($10.000)\nM4 ($15.000)\nGrenade ($10.000) [VIP]\nHealth ($2.500)\nArmour ($5.000)", "Buy", "Exit");
	return 1;
}

CMD:cshop(playerid) // CMD for calling a shop
{
    ShowPlayerDialog(playerid, DIALOG_CSHOP, DIALOG_STYLE_LIST, "Cookies Shop", "Armour (2 cookies)\nM4 (5 cookies)", "Buy", "Exit");
	return 1;
}

CMD:kill(playerid) // CMD to commit a suicide
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:stats(playerid) // CMD to see your stats
{
    new str[128];
   	format(str, sizeof(str), "VIP level - [%s], Admin level - [%s], Kills - [%i], Deaths - [%i], Warnings - [%i], Report muted - [%s], Cookies - [%i]", GetVipLvlName(playerid), GetAdminLvlName(playerid), PlayerInfo[playerid][pKills], PlayerInfo[playerid][pDeaths], PlayerInfo[playerid][pWarns], YesNoChecker(PlayerInfo[playerid][pReportMuted]), PlayerInfo[playerid][pCookies]);
	SendClientMessage(playerid, COLOR_WHITE, str);
	return 1;
}

CMD:report(playerid,params[]) // CMD for report to admin
{
	if(PlayerInfo[playerid][pReportMuted] == 1)
	{
		SendClientMessage(playerid, COLOR_RED, "You are currently muted from using /report");
		return 0;
	}
	else
	{
		new sendername[MAX_PLAYER_NAME], string[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		sendername[strfind(sendername,"_")] = ' ';
		if(isnull(params)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /report [text]");
    	format(string, sizeof(string), "Report From %s: %s", sendername, params);
		ABroadCast(COLOR_RED,string,1);
	}
	return 1;
}

CMD:help(playerid) // CMD for sending the client a list of available CMD's
{
    ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help", "Player commands\nAdmin commands\nVIP commands", "Select", "Exit");
	return 1;
}

CMD:pm(playerid,params[]) // CMD for PM'ing someone
{
	new pid;
	new msg[128];
	new str[128];
	if(sscanf(params, "us[128]", pid, msg)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /pm [Player ID] [Message]");
	if(playerid == pid) return SendClientMessage(playerid,COLOR_RED,"You can't message yourself!");
	format(str, sizeof(str), "Message from %s: %s", GetName(playerid), msg);
	SendClientMessage(pid, COLOR_PM, str);
	format(str, sizeof(str), "Message to %s: %s", GetName(pid), msg);
	SendClientMessage(playerid, COLOR_PM, str);
	return 1;
}

// End of regular players CMD's section

//---------------------------------------------------------------------------------------------------------------

// Admin CMD's section

CMD:makevip(playerid, params[]) // CMD for making someone a VIP...
{
	new pid;
	new vlevel;
	new str[128];
	if(sscanf(params,"ui", pid, vlevel)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /makevip [Player ID] [VIPlevel]");
	if (PlayerInfo[playerid][pAdmin]==5)
	{
	    if((vlevel<=2)&&(vlevel>=0))
	 	{
   			if(pid==playerid) return PlayerInfo[pid][pVip] = vlevel;
		    if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
			format(str, sizeof(str), "You just granted %s level %i VIP!", GetName(pid), vlevel);
			SendClientMessage(playerid, COLOR_RED, str);
			format(str, sizeof(str), "You have been given a level %i VIP by an Admin!", vlevel);
			SendClientMessage(pid, COLOR_RED, str);
			PlayerInfo[pid][pVip] = vlevel;
        }
		else SendClientMessage(playerid, COLOR_WHITE, "VIP level is between 1 and 2");
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:goto(playerid, params[]) // CMD to go to someone
{
    new pid;
	if(IsPlayerConnected(pid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=2)
	    {
			if(!sscanf(params, "ui", pid))
			{
			    new string[64];
			    new Float:x, Float:y, Float:z;	GetPlayerPos(pid,x,y,z); SetPlayerInterior(playerid,GetPlayerInterior(pid));
			    format(string, sizeof(string), "You teleported yourself to %s .", GetName(pid));
			    SendClientMessage(playerid, COLOR_RED, string);
				SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(pid));
			    SetPlayerPos(playerid,x+2,y,z);
			    return 1;
			}
			else return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /goto [PlayerID/PartOfName]");
	    }
	    else return SendClientMessage(playerid, COLOR_RED, "You must be an admin to use this command!");
	}
	else return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
}

CMD:gethere(playerid, params[]) // CMD to get someone to you
{
    new pid;
	if(IsPlayerConnected(pid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=2)
	    {
			if(!sscanf(params, "ui", pid))
			{
			    new string[64];
			    new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(pid,GetPlayerInterior(playerid));
			    format(string, sizeof(string), "You teleported %s to you.", GetName(pid));
			    SendClientMessage(playerid, COLOR_RED, string);
				SetPlayerVirtualWorld(pid,GetPlayerVirtualWorld(playerid));
			    SetPlayerPos(pid,x+2,y,z);
			    return 1;
			}
			else return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gethere [PlayerID/PartOfName]");
	    }
	    else return SendClientMessage(playerid, COLOR_RED, "You must be an admin to use this command!");
	}
	else return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
}

CMD:makeadmin(playerid, params[]) // CMD for making someone an admin...
{
	new pid;
	new alevel;
	new str[128];
	if(sscanf(params,"ui", pid, alevel)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /makeadmin [Player ID] [Admin level]");
	if (PlayerInfo[playerid][pAdmin]==5)
	{
	    if((alevel<=5)&&(alevel>=0))
	 	{
	 	    if(pid==playerid) return SendClientMessage(playerid, COLOR_RED, "You can't change your admin level!");
   			if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
			format(str, sizeof(str), "You just granted %s level %i Admin!", GetName(pid), alevel);
			SendClientMessage(playerid, COLOR_RED, str);
			format(str, sizeof(str), "You have been given a level %i admin by an Admin!", alevel);
			SendClientMessage(pid, COLOR_RED, str);
			PlayerInfo[pid][pAdmin] = alevel;
		}
		else SendClientMessage(playerid, COLOR_WHITE, "Admin level is between 1 and 5");
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:rmakeadmin(playerid, params[]) // CMD for making someone an admin...
{
	new pid;
 	new alevel;
	new str[128];
	if(sscanf(params,"ui", pid, alevel)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /rmakeadmin [Player ID] [Admin level]");
	if (IsPlayerAdmin(playerid))
	{
	    if((alevel<=5)&&(alevel>=0))
	 	{
	 	    if(pid==playerid) return PlayerInfo[pid][pAdmin] = alevel;
	 	    if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
			format(str, sizeof(str), "You just granted %s level %i Admin!", GetName(pid), alevel);
			SendClientMessage(playerid, COLOR_RED, str);
			format(str, sizeof(str), "You have been given a level %i admin by an Admin!", alevel);
			SendClientMessage(pid, COLOR_RED, str);
			PlayerInfo[pid][pAdmin] = alevel;
		}
		else SendClientMessage(playerid, COLOR_WHITE, "Admin level is between 1 and 5");
	}
	else SendClientMessage(playerid, COLOR_RED, "You must be RCON admin to use that command!");
	return 1;
}

CMD:ban(playerid, params[]) // CMD for banning someone
{
	new pid;
	new str[128];
	new reason;
	if(sscanf(params,"us", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [Player ID] [Reason]");
	if (PlayerInfo[playerid][pAdmin]>=3)
	{
   		if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
		if(PlayerInfo[playerid][pAdmin]<=PlayerInfo[pid][pAdmin]) return SendClientMessage(playerid, COLOR_RED, "PlayerID is higher admin rank, can't ban him!");
		if(playerid==pid) return SendClientMessage(playerid, COLOR_RED, "You can't ban yourself!");
		format(str, sizeof(str), "You have banned %s. Reason: %s", GetName(pid), reason);
		SendClientMessage(playerid, COLOR_RED, str);
		format(str, sizeof(str), "ADMCMD: %s have been banned by %s. Reason: %s", GetName(pid), GetName(playerid), reason );
		SendClientMessageToAll(COLOR_RED, str);
		PlayerInfo[pid][pBanned] = 1;
		Kick(pid);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:unban(playerid, params[]) // CMD for unbanning someone
{
	new pName[MAX_PLAYER_NAME];
	new str[128];
	if(sscanf(params,"s[MAX_PLAYER_NAME]", pName)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /unban [Player Name]");
	if (PlayerInfo[playerid][pAdmin]>=3)
	{
   		if(!fexist(UserAccount(pName))) return SendClientMessage(playerid, COLOR_RED, "Player doesn't exist.");
   		new INI:File = INI_Open(UserAccount(pName));
		INI_WriteInt(File,"Banned", 0);
		INI_WriteInt(File,"Warnings",0);
    	INI_Close(File);
    	format(str, sizeof(str), "You have unbanned %s.", pName);
		SendClientMessage(playerid, COLOR_RED, str);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:kick(playerid, params[]) // CMD for unbanning someone
{
	new pid;
	new str[128];
	new reason;
	if(sscanf(params,"us", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [Player ID] [Reason]");
	if (PlayerInfo[playerid][pAdmin]>=1)
	{
   		if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
   		if(PlayerInfo[playerid][pAdmin]<=PlayerInfo[pid][pAdmin]) return SendClientMessage(playerid, COLOR_RED, "PlayerID is higher admin rank, can't kick him!");
    	format(str, sizeof(str), "You have kicked %s. Reason: %s", GetName(pid), reason);
		SendClientMessage(playerid, COLOR_RED, str);
		format(str, sizeof(str), "%s have been kicked by %s. Reason: %s", GetName(pid), GetName(playerid), reason);
		SendClientMessage(playerid, COLOR_RED, str);
		Kick(playerid);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:givecash(playerid, params[]) // CMD to give somebody some cash
{
	new amount;
	new pid;
	new str[128];
	if(sscanf(params, "ui", pid, amount)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [Player ID] [Amount]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if (PlayerInfo[playerid][pAdmin]>=3)
	{
	 GivePlayerMoney(pid, amount);
	 format(str, sizeof(str), "You have been granted $%i by an Admin!", amount);
	 SendClientMessage(pid, COLOR_RED, str);
	 format(str, sizeof(str), "You just gave $%i to %s.", amount, GetName(pid));
	 SendClientMessage(playerid, COLOR_RED, str);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
 	return 1;
}

CMD:givecookie(playerid, params[]) // CMD for giving somebody a cookie
{
    new pid;
    new reason[128];
    new str[128];
    if(sscanf(params, "us[128]", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecookie [Player ID] [Reason]");
    if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
    if (PlayerInfo[playerid][pAdmin]>=4)
    {
     format(str, sizeof(str), "%s have been granted a cookie by %s. Reason: %s", GetName(pid), GetName(playerid), reason);
     SendClientMessageToAll(COLOR_RED, str);
     format(str, sizeof(str), "You just gave a cookie to %s.", GetName(pid));
     SendClientMessage(playerid, COLOR_RED, str);
     PlayerInfo[pid][pCookies] ++;
    }
    else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
    return 1;
}

CMD:sethealth(playerid, params[]) // CMD for setting someone his health
{
	new amount;
	new pid;
	new str[128];
	if(sscanf(params, "ui", pid, amount)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sethealth [Player ID] [Amount]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if (PlayerInfo[playerid][pAdmin]>=2)
	{
	 SetPlayerHealth(pid, amount);
	 format(str, sizeof(str), "Your health has been set to $%i by an Admin!", amount);
	 SendClientMessage(pid, COLOR_RED, str);
	 format(str, sizeof(str), "You just set %s's health to %i.", GetName(pid), amount);
	 SendClientMessage(playerid, COLOR_RED, str);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
 	return 1;
}

CMD:setarmour(playerid, params[]) // CMD for setting someone his armour
{
	new amount;
	new pid;
	new str[128];
	if(sscanf(params, "ui", pid, amount)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /setarmour [Player ID] [Amount]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if (PlayerInfo[playerid][pAdmin]>=2)
	{
	 SetPlayerArmour(pid, amount);
	 format(str, sizeof(str), "Your armour has been set to $%i by an Admin!", amount);
	 SendClientMessage(pid, COLOR_RED, str);
	 format(str, sizeof(str), "You just set %s's armour to %i.", GetName(pid), amount);
	 SendClientMessage(playerid, COLOR_RED, str);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
 	return 1;
}

CMD:resetstats(playerid, params[]) // CMD for resetting somebody's stats
{
	new pid;
	new str[128];
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /resetstats [Player ID]. NOTE: Stats will be lost forever.");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if (PlayerInfo[playerid][pAdmin]>=5)
	{
	            if(PlayerInfo[playerid][pAdmin]==PlayerInfo[pid][pAdmin]) return SendClientMessage(playerid, COLOR_RED, "You can't reset stats of another owner!");
				format(str, sizeof(str), "Your stats have been reset. You were kicked to apply your new stats.");
				SendClientMessage(pid, COLOR_RED, str);
				format(str, sizeof(str), "You just reset %s's stats.", GetName(pid));
				SendClientMessage(pid, COLOR_RED, str);
				format(str, sizeof(str), "ADMCMD: %s just reset %s's stats.", GetName(playerid), GetName(pid));
				SendClientMessage(pid, COLOR_RED, str);
				new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Cash",3000);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"VIP",0);
                INI_WriteInt(File,"Banned",0);
                INI_WriteInt(File,"Warnings",0);
                INI_WriteInt(File,"Report mute",0);
                Kick(pid);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
 	return 1;
}

CMD:fine(playerid, params[]) // CMD for fining someone
{
	new pid;
	new str[128];
	new amount;
	new reason;
	if(sscanf(params, "uis", pid, amount, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /fine [Player ID] [Amount] [Reason]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if(PlayerInfo[playerid][pAdmin]>=2)
	{
 		if(amount==0) return SendClientMessage(playerid, COLOR_WHITE, "You can't fine someone 0 dollars!");
	 	GivePlayerMoney(pid, -amount);
	 	format(str, sizeof(str), "ADMCMD: %s has been fined $%i by %s. Reason: %s", GetName(pid), amount, GetName(playerid), reason);
	 	SendClientMessageToAll(COLOR_RED, str);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:warn(playerid, params[]) // CMD for warning someone
{
	new pid;
	new str[128];
	new reason;
	if(sscanf(params, "us", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /warn [Player ID] [Reason]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if(PlayerInfo[playerid][pAdmin]>=1)
	{
	    if(PlayerInfo[pid][pAdmin]>=PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_WHITE, "You can't warn this player: he's higher admin rank!");
	    if(PlayerInfo[pid][pWarns]>=4)
	    {
            PlayerInfo[pid][pWarns]++;
            PlayerInfo[pid][pBanned]++;
   			format(str, sizeof(str), "ADMCMD: %s has been warned by an %s. Reason: %s", GetName(pid), GetName(playerid), reason);
        	SendClientMessageToAll(COLOR_RED, str);
			format(str, sizeof(str), "AUTO-BAN: %s has been automatically banned. Reason: Too much warnings.", GetName(pid));
        	SendClientMessageToAll(COLOR_RED, str);
        	Kick(pid);
	   }
	    else
	   {
            PlayerInfo[pid][pWarns]++;
        	format(str, sizeof(str), "ADMCMD: %s has been warned by an %s. Reason: %s", GetName(pid), GetName(playerid), reason);
        	SendClientMessageToAll(COLOR_RED, str);
	   }
	}
	return 1;
}

CMD:a(playerid,params[]) // CMD for admin chat
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new sendername[MAX_PLAYER_NAME], string[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		sendername[strfind(sendername,"_")] = ' ';
		if(isnull(params)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /(a)say [text]");
    	format(string, sizeof(string), "[%s] %s: %s", GetAdminLvlName(playerid), sendername, params);
		ABroadCast(COLOR_RED,string,1);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:asay(playerid,params[]) // Alt. CMD for admin chat
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new sendername[MAX_PLAYER_NAME], string[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		sendername[strfind(sendername,"_")] = ' ';
		if(isnull(params)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /(a)say [text]");
    	format(string, sizeof(string), "[%s] %s: %s", GetAdminLvlName(playerid), sendername, params);
		ABroadCast(COLOR_RED,string,1);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: You must be an admin to use that command!");
	return 1;
}

CMD:reportmute(playerid, params[]) // CMD for muting someone from report
{
	new pid;
	new str[128];
	new reason;
	if(sscanf(params, "us", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /reportmute [Player ID] [Reason] (This commands is also used to unmute. Type 'null' reason when unmute.)");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "PlayerID is not connected.");
	if(PlayerInfo[playerid][pAdmin]>=2)
	{
	    if(PlayerInfo[pid][pAdmin]>=PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_WHITE, "You can't mute this player: he's higher admin rank!");
	    if(PlayerInfo[pid][pReportMuted]==0)
	    {
	    	new INI:File = INI_Open(UserPath(playerid));
     		INI_SetTag(File,"data");
        	INI_WriteInt(File,"Reportmute",PlayerInfo[pid][pReportMuted]+1);
        	INI_Close(File);
   			format(str, sizeof(str), "ADMCMD: %s has been report muted by %s. Reason: %s", GetName(pid), GetName(playerid), reason);
        	SendClientMessageToAll(COLOR_RED, str);
	   }
	    else
	   {
	    	new INI:File = INI_Open(UserPath(playerid));
     		INI_SetTag(File,"data");
        	INI_WriteInt(File,"Reportmute",PlayerInfo[pid][pReportMuted]-1);
        	INI_Close(File);
        	format(str, sizeof(str), "ADMCMD: %s has been report unmuted by %s.", GetName(pid), GetName(playerid));
        	SendClientMessageToAll(COLOR_RED, str);
	   }
	}
	return 1;
}

// End of admin CMD's section

//---------------------------------------------------------------------------------------------------------------

// VIP CMD's section

CMD:vc(playerid,params[]) // CMD for VIP chat
{
	if(PlayerInfo[playerid][pVip] >= 1)
	{
	    if(PlayerInfo[playerid][pTogVC] == 0)
	    {
	    	new sendername[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			sendername[strfind(sendername,"_")] = ' ';
			if(isnull(params)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /vc [text]");
    		format(string, sizeof(string), "[%s] %s: %s", GetVipLvlName(playerid), sendername, params);
			VBroadCast(COLOR_VIP,string,1);
		}
		else SendClientMessage(playerid, COLOR_RED, "VIP chat toggled off, turn it on!");
	}
	else SendClientMessage(playerid, COLOR_RED, "You must be VIP to use that command!");
	return 1;
}

CMD:togvc(playerid) // CMD for toggling VIP chat
{
	if(PlayerInfo[playerid][pVip] >= 1)
	{
	    if(PlayerInfo[playerid][pTogVC] == 0)
	    {
            PlayerInfo[playerid][pTogVC] = 1;
        	SendClientMessage(playerid, COLOR_RED, "You have disabled VIP chat.");
		}
		else
		{
        	PlayerInfo[playerid][pTogVC] = 0;
        	SendClientMessage(playerid, COLOR_RED, "You have enabled VIP chat.");
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "You must be VIP to use that command!");
	return 1;
}

// End of VIP CMD's section


//-------------------------------------------------------Publics-------------------------------------------------
public BallasCar(carid)
{
	for(new i = 0; i < sizeof(ballascar); i++)
	{
		if(carid == ballascar[i])	return 1;
	}
	return 0;
}
public VagosCar(carid)
{
	for(new i = 0; i < sizeof(vagoscar); i++)
	{
		if(carid == vagoscar[i])	return 1;
	}
	return 0;
}
public GroveCar(carid)
{
	for(new i = 0; i < sizeof(grovecar); i++)
	{
		if(carid == grovecar[i])	return 1;
	}
	return 0;
}
public CopCar(carid)
{
	for(new i = 0; i < sizeof(copcar); i++)
	{
		if(carid == copcar[i])	return 1;
	}
	return 0;
}
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Int("VIP",PlayerInfo[playerid][pVip]);
    INI_Int("Banned",PlayerInfo[playerid][pBanned]);
    INI_Int("VC",PlayerInfo[playerid][pTogVC]);
    INI_Int("Cookies",PlayerInfo[playerid][pCookies]);
    INI_Int("Weapon0",PlayerInfo[playerid][pWeapon][0]);
    INI_Int("Weapon1",PlayerInfo[playerid][pWeapon][1]);
    INI_Int("Weapon2",PlayerInfo[playerid][pWeapon][2]);
    INI_Int("Weapon3",PlayerInfo[playerid][pWeapon][3]);
    INI_Int("Weapon4",PlayerInfo[playerid][pWeapon][4]);
    INI_Int("Weapon5",PlayerInfo[playerid][pWeapon][5]);
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys == KEY_YES) return ShowPlayerDialog(playerid, DIALOG_SHOP, DIALOG_STYLE_LIST, "Shop", "Deagle ($10.000)\nM4 ($15.000)\nGrenade ($10.000) [VIP]\nHealth ($2.500)\nArmour ($5.000)", "Buy", "Exit");
    if (newkeys == KEY_NO) return ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help", "Player commands\nAdmin commands\nVIP commands", "Select", "Exit");
	return 1;
}


public ABroadCast(color,const string[],level)
{
	for(new pid = 0; pid < MAX_PLAYERS; pid++)
	{
		if(IsPlayerConnected(pid))
		{
			if (PlayerInfo[pid][pAdmin] >= level)
			{
				SendClientMessage(pid, color, string);
			}
		}
	}
	return 1;
}

public VBroadCast(color,const string[],level)
{
	for(new pid = 0; pid < MAX_PLAYERS; pid++)
	{
		if(IsPlayerConnected(pid))
		{
		    if (PlayerInfo[pid][pTogVC] == 0)
		    {
				if (PlayerInfo[pid][pVip] >= level)
				{
					SendClientMessage(pid, color, string);
				}
			}
		}
	}
	return 1;
}

//--------------------------------------------------Stocks-------------------------------------------------------
stock CreateLableText(playerid,lable[],text[])
{
    //if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
    //if(GetPVarInt(playerid, "PlayTime") < 5) return 1;
    new string[128];
    if(GetPVarInt(playerid, "LableDraw") > 0)
    {
        TextDrawSetString(Text:LableDraw[playerid],lable);
        format(string, sizeof(string),"~n~~n~%s~n~~n~",text);
        return TextDrawSetString(Text:UsedDraw[playerid],string);
    }
	PlayerPlaySound(playerid,1054, 0.0, 0.0, 0.0);
    TextDrawHideForPlayer(playerid,LableDraw[playerid]);
    TextDrawShowForPlayer(playerid,LableDraw[playerid]);
    TextDrawSetString(Text:LableDraw[playerid],lable);
    TextDrawDestroy(UsedDraw[playerid]);
    UsedDraw[playerid] = TextDrawCreate(440.000000,173.000000," ");
    TextDrawUseBox(UsedDraw[playerid],1);
    TextDrawBoxColor(UsedDraw[playerid],0x00000066);
    TextDrawTextSize(UsedDraw[playerid],636.000000,308.000000);
    TextDrawAlignment(UsedDraw[playerid],0);
    TextDrawBackgroundColor(UsedDraw[playerid],0x000000ff);
    TextDrawFont(UsedDraw[playerid],2);
    TextDrawLetterSize(UsedDraw[playerid],0.300000,1.000000);
    TextDrawColor(UsedDraw[playerid],0xffffffff);
    TextDrawSetOutline(UsedDraw[playerid],1);
    TextDrawSetProportional(UsedDraw[playerid],1);
    TextDrawSetShadow(UsedDraw[playerid],1);
    TextDrawShowForPlayer(playerid,UsedDraw[playerid]);
    format(string, sizeof(string),"~n~~n~%s~n~~n~",text);
    TextDrawSetString(Text:UsedDraw[playerid],string);
    return SetPVarInt(playerid, "LableDraw", 4);
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

stock UserAccount(string[])
{
	new File[128];
    format(File,sizeof(File),PATH,string);
    return File;
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock GetName(playerid)
{
    new Name[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, Name, sizeof(Name));
	}
	return Name;
}


stock GetVipLvlName(playerid)
{
	new str[64];
	if (PlayerInfo[playerid][pVip] == 0) str = ("None");
	if (PlayerInfo[playerid][pVip] == 1) str = ("VIP");
	if (PlayerInfo[playerid][pVip] == 2) str = ("Gold VIP");
	return str;
}

stock GetAdminLvlName(playerid)
{
	new str[64];
	if (PlayerInfo[playerid][pAdmin] == 0) str = ("None");
	if (PlayerInfo[playerid][pAdmin] == 1) str = ("Administrator level 1");
	if (PlayerInfo[playerid][pAdmin] == 2) str = ("Administrator level 2");
	if (PlayerInfo[playerid][pAdmin] == 3) str = ("Administrator level 3");
	if (PlayerInfo[playerid][pAdmin] == 4) str = ("Senior administrator");
	if (PlayerInfo[playerid][pAdmin] == 5) str = ("Lead administrator");
	return str;
}

stock YesNoChecker(params)
{
	new str[64];
	if (params == 0) str = ("No");
	if (params == 1) str = ("Yes");
	return str;
}

//---------------------------------------------------------------------------------------------------------------
	
