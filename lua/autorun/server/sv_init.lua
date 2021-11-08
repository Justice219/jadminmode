util.AddNetworkString("JAMChatMessage")
util.AddNetworkString("JAMChatAMessage")

local Ranks = {
    ["superadmin"] = true,
    ["headadmin"] = true,
    ["admin"] = true,
    ["tmod"] = true,
    ["mod"] = true,
    ["operator"] = true,
    ["user"] = false,
}

local ARanks = {
    ["superadmin"] = true,
    ["owner"] = true,
    ["headadmin"] = true,
}

local function CheckJAM(ply)
    if not (Ranks[ply:GetUserGroup()]) then return end
    if ply.jamActive == true then

        ply.jamActive = false
        net.Start("JAMChatMessage")
        net.WriteString("Admin Mode has been disabled!")
        net.Send(ply)
        MsgC(Color(245, 242, 66), "[Admin Mode]", Color(255,255,255), " A user has disabled admin mode!")

        -- Run our console commands
        ply:GodDisable()
        RunConsoleCommand("sam", "uncloak", ply:SteamID())
        timer.Simple( 2, function()
            RunConsoleCommand("sam", "noclip", ply:SteamID())
            RunConsoleCommand("sam", "ungod", ply:SteamID())
        end )

        for k, v in ipairs(player.GetAll()) do
            if not (ARanks[v:GetUserGroup()]) then return end
            net.Start("JAMChatAMessage")
            net.WriteString("has disabled admin mode!")
            net.WriteEntity(ply)
            net.Send(v)
        end

    else
        ply.jamActive = true
        net.Start("JAMChatMessage")
        net.WriteString("Admin Mode has been activated!")
        net.Send(ply)
        MsgC(Color(245, 242, 66), "[Admin Mode]", Color(255,255,255), " A user has activated admin mode!")

        -- Run our console commands
        ply:GodEnable()
        RunConsoleCommand("sam", "cloak", ply:SteamID())
        timer.Simple( 2, function()
            RunConsoleCommand("sam", "noclip", ply:SteamID())
            RunConsoleCommand("sam", "god", ply:SteamID())
        end )

        for k, v in ipairs(player.GetAll()) do
            if not (ARanks[v:GetUserGroup()]) then return end
            net.Start("JAMChatAMessage")
            net.WriteString("has enabled admin mode!")
            net.WriteEntity(ply)
            net.Send(v)
        end

    end
end

hook.Add("PlayerSay", "JAMCH", function(ply, text)
    if string.lower(text) == "!jam" then
        CheckJAM(ply)
    end
end)

hook.Add("PlayerSpawn", "JAMPS", function(ply, t)
    if ply.jamActive then
        RunConsoleCommand("sam", "cloak", ply:SteamID())
        RunConsoleCommand("sam", "god", ply:SteamID())
        RunConsoleCommand("sam", "noclip", ply:SteamID())
    end
end)
