// Variable to store seconds paused
new PlayerPause[MAX_PLAYERS];

public OnPlayerUpdate(playerid)
{
	PlayerPause[playerid] = 0; // OnPlayerUpdate does not work in pause, so it will be set to 0 (If not paused)
}

// Now you need to add code for the player's second timer
public ExamplePlayerTimer(playerid)
{
	new df[64];

	PlayerPause[playerid] = PlayerPause[playerid] + 1; // Каждую секунду добавляем для игрока секунду
	
	// If he's on pause, OnPlayerUpdate will not work, therefore 0 will not be installed
	if(PlayerPause[playerid] != 0)
	{
		// Convert
		new pause_min = ConvertUnixTime(PlayerPause[playerid], CONVERT_TIME_TO_MINUTES);
		new pause_sec = ConvertUnixTime(PlayerPause[playerid]);

		if(pause_min > 0) // Checking whether minutes are in a pause (if more than a minute - a different format)
		{
			format(df, sizeof df, "Paused %d:%02d", pause_min, pause_sec);
		}
		else format(df, sizeof df, "Paused %d seconds.", pause_sec); // If less than a minute

		SetPlayerChatBubble(playerid, df, 0xFF0000FF, 7.0, 1500);
	}
}

// ConvertUnixTime
stock ConvertUnixTime(unix_time, type = CONVERT_TIME_TO_SECONDS)
{
	switch(type)
	{
		case CONVERT_TIME_TO_SECONDS:
		{
			unix_time %= 60;
		}
		case CONVERT_TIME_TO_MINUTES:
		{
			unix_time = (unix_time / 60) % 60;
		}
		case CONVERT_TIME_TO_HOURS:
		{
			unix_time = (unix_time / 3600) % 24;
		}
		case CONVERT_TIME_TO_DAYS:
		{
			unix_time = (unix_time / 86400) % 30;
		}
		case CONVERT_TIME_TO_MONTHS:
		{
			unix_time = (unix_time / 2629743) % 12;
		}
		case CONVERT_TIME_TO_YEARS:
		{
			unix_time = (unix_time / 31556926) + 1970;
		}
		default:
			unix_time %= 60;
	}
	return unix_time;
}
