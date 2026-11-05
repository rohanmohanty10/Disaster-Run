  

 

local TextChatService = game:GetService("TextChatService");

return function(p1, p2) -- Line: 2
    -- upvalues: TextChatService (copy)
    TextChatService:DisplayBubble(p1, p2);
end;