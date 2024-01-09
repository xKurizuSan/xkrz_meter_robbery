Config = {}

Config.Framework = 'esx'                                 -- qb oder esx

Config.ParkingMeterProps = {
    'prop_parknmeter_01',
    'prop_parknmeter_02'
}

Config.MinAmount = 500                                  -- Wie viel der Spieler Mininmal bekommen kann.
Config.MaxAmount = 2000                                 -- Wie viel der Spieler Maximal bekommen kann.
Config.UseItem = 'lockpick'                             -- Das Item welches am Ende verbraucht wird.

Config.Cooldown = 60000 * 5                             -- Die Zeit wie lange es dauert bis der Spieler eine weiter Parkuhr knacken kann. Standard 5 Minuten

Config.SkillCheckDifficulty = {'easy', 'easy', 'easy'}  -- Wie schwer soll der SkillCheck werden? 'easy' 'medium' 'hard' 
Config.SkillCheckKeys = {'e'}                           -- Welche Tasten sollen gedrückt werden? {'1'}, {'2'}, {'3'}, {'4'} oder {'w'}, {'a'}, {'s'}, {'d'}
