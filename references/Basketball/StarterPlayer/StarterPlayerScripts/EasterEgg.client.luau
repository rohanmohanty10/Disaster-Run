 
 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = false;

for _, v in { 4203884193, 963682597, 2589417948 } do
    if LocalPlayer.UserId == v then
        v1 = true;
        break;
    end;
end;

if v1 then
    require(script.Initialize).initialize();

    return;
end;

script:Destroy();