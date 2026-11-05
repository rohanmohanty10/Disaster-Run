 

 

if game.GameId == 1016936714 or (game.PlaceId == 2809202155 or (game.PlaceId == 4572813082 or (game.PlaceId == 4643697430 or (game.PlaceId == 5290908008 or game.PlaceId == 5818061503)))) then
    print("Whitelist Disabled");
    script:Destroy();
else
    print("Whitelist Activated");
    local l__LocalPlayer__1 = game.Players.LocalPlayer;
    if game:GetService("RunService"):IsStudio() then
    else
        local l__Value__2 = script:WaitForChild("Testing").Value;
        local l__Value__3 = script:WaitForChild("CMTesting").Value;
        local l__Value__4 = script:WaitForChild("PlayTesters").Value;
        if l__LocalPlayer__1:IsInGroup(3194064) then
            local v1 = l__LocalPlayer__1:GetRankInGroup(3194064);
            if not l__Value__2 and v1 >= 1 or (not l__Value__3 and v1 >= 3 or (v1 >= 7 or (v1 == 4 or l__Value__4 and v1 == 3))) then
                return;
            end;
        end;
        while true do
            wait();
            l__LocalPlayer__1:Kick("Game is in a private testing session where your permissions aren\'t high enough to join.");
            print("Kicked");
        end;
    end;
end;