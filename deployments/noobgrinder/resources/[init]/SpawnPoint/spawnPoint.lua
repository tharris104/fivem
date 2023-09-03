-- define a local variable called `spawnPos` with a coordinate somewhere on the map
-- Lua in FiveM (through CfxLua) supports first-class vectors, which in this case can be accessed using .x, .y and .z.
local spawnPos = vector3(426.1223, -979.7187, 30.70979)

-- add an event handler for the (local) event called 'onClientGameTypeStart'.
-- it takes no arguments in this case (in Lua you can omit arguments), since our resource is a game type and you can only run one at once,
-- that means this will basically run when we start ourselves on the client. nice!
AddEventHandler('onClientGameTypeStart', function()
    -- set an automatic spawn callback for the spawn manager.
    -- normally, this works using hardcoded spawn points, but since this is a scripting tutorial, we'll do it this way.
    --
    -- the spawn manager will call this when the player is dead, or when forceRespawn is called.
    exports.spawnmanager:setAutoSpawnCallback(function()
        -- spawnmanager has said we should spawn, let's spawn!
        exports.spawnmanager:spawnPlayer({
            -- this argument is basically a table containing the spawn location...
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            -- ... and the model to spawn as.
            model = 'a_m_m_skater_01'
        }, function()
            -- a callback to be called once the player is spawned in and the game is visible
            -- in this case, we just send a message to the local chat box.
            TriggerEvent('chat:addMessage', {
                args = { 'Welcome to the party!~' }
            })
        end)
    end)

    -- enable auto-spawn
    exports.spawnmanager:setAutoSpawn(true)

    -- and force respawn when the game type starts
    exports.spawnmanager:forceRespawn()
end)
