  

 

return function(p1) -- Line: 1
    for _, child in pairs(game:GetService("ReplicatedStorage")["Client Assets"].Blocking:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            local Attachment = Instance.new("Attachment");
            Attachment.Position = Vector3.new(0, -0.74, -1.321);
            Attachment.Parent = p1.PrimaryPart;
            local v2 = child:Clone();
            v2.Parent = Attachment;
            v2:Emit(v2.Rate / 2);
            game:GetService("Debris"):AddItem(Attachment, v2.Lifetime.Max);
        end;
    end;
end;