fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    'util/client.lua',
    'framework/client/*.lua',
    'modules/*.lua',
    'editable.lua',
    'client.lua',
    '@qbx_core/modules/playerdata.lua'
}

server_scripts {
    'framework/server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared.lua'
}

escrow_ignore {
    'editable.lua',
    'shared.lua',
    'modules/stress.lua',
    'framework/client/*.lua',
    'framework/server/*.lua',
}

ui_page 'ui/dist/index.html'

files {
    'ui/dist/index.html',
	'ui/dist/assets/*.js',
    'ui/dist/assets/*.css',
    'ui/dist/assets/*.png',
    'ui/dist/assets/*.otf',
    'ui/dist/assets/*.mp3',
}

exports {
    'ShowHud',
}

