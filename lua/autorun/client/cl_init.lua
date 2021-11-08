local function ChatHandler(msg)
    chat.AddText(Color(245, 242, 66), "[Admin Mode] ", Color(255,255,255), msg)
end

local function ChatHandlerStaff(msg, ply)
    chat.AddText(Color(245, 242, 66), "[Admin Mode] ", Color(255,255,255), "A player named: " .. ply:Nick() .. " " .. msg)
end

net.Receive("JAMChatMessage", function(len, ply)

    local msg = net.ReadString()
    ChatHandler(msg)

end)

net.Receive("JAMChatAMessage", function(len, ply)

    local msg = net.ReadString()
    local plt = net.ReadEntity()
    ChatHandlerStaff(msg, plt)

end)