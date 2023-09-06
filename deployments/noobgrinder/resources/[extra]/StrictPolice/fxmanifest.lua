--[[
StrictPolice - this mod opens 2 threads. one which modifies
               police behavior at different wanted levels. and
               another which looks for the closest PED which
               is police, has line of sight on the player, and
               sees the player doing a crime.
]]
fx_version 'cerulean'
games { 'gta5' }

author 'nemesis104'
description 'Police trigger wanted level based on certain events'
version '1.0'

client_script "client.lua"
