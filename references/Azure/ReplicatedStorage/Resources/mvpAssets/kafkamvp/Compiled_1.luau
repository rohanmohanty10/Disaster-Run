 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Scene1);

            for _, descendant in pairs(p1.Scene1:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 131, function(p2) -- Line: 15
            for _, descendant in pairs(p2.Scene1:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p2.Scene2:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p2.Scene2);
        end },
    { 160, function(p3) -- Line: 34
            shared.vfx.emit(p3.Smoke);
        end },
    { 219, function(p4) -- Line: 39
            for _, descendant in pairs(p4.Scene2:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p4.Scene3:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p4.Scene3);
        end },
    { 254, function(p5, p6) -- Line: 58
            shared.vfx.emit(p6["Kafka Coin"].Union["1"]);
        end },
    { 290, function(p7, p8) -- Line: 63
            shared.vfx.emit(p8["Kafka Coin"].Union["2"]);
        end },
    { 384, function(p9) -- Line: 68
            for _, descendant in pairs(p9.Scene3:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p9.Scene4:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p9.Scene4);
        end },
    { 658, function(p10, p11, p12) -- Line: 87
            for _, descendant in pairs(p10.Scene4:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p10.Scene5:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p10.Scene5);
            shared.vfx.emit(p12.CamPart);
        end },
    { 682, function(p13) -- Line: 107
            shared.vfx.emit(p13.ScreenEffect0);
        end },
    { 746, function(p14) -- Line: 112
            shared.vfx.emit(p14.ScreenEffect0);
        end },
    { 809, function(p15) -- Line: 117
            shared.vfx.emit(p15.ScreenEffect);
        end },
    { 878, function(p16) -- Line: 122
            shared.vfx.emit(p16.ScreenEffect);
        end },
    { 933, function(p17) -- Line: 127
            shared.vfx.emit(p17.ScreenEffect1);
        end },
    { 983, function(p18) -- Line: 132
            for _, descendant in pairs(p18.Scene5:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};