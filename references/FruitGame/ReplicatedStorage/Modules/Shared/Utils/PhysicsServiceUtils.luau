 

game:GetService("PhysicsService")
return {
    ["SetCharacterCollision"] = function(_, p1, p2) --[[ Name: SetCharacterCollision, Line 5 ]]
        if p1.PrimaryPart.CollisionGroup ~= p2 then
            for _, v3 in ipairs(p1:GetChildren()) do
                if v3:IsA("BasePart") and v3.CollisionGroupId ~= 1 then
                    _G.setCollisionGroup(v3, p2)
                end
            end
        end
    end
}