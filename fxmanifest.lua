fx_version 'bodacious'
lua54 'yes'
game  'gta5'

author ".viperino"

version '1.0'
 
client_scripts{
	'client/client.lua', 
	'@es_extended/locale.lua' 
 
}

server_scripts{
	'server/server.lua',
	'@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua' 
 
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua', 
  }

  dependencies {
	'ox_inventory',
	'oxmysql',
	'ox_lib',
}
