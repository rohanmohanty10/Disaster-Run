 

 

return {
    bottom = function(p1, p2) -- Line: 4, Name: bottom
        local Notifications = p1:FindFirstChild("Notifications");

        if Notifications then
            Notifications = Notifications:FindFirstChild("MainFrame");
        end;

        if Notifications then
            Notifications = Notifications:FindFirstChild("NotificationsF");
        end;

        local v3;

        if Notifications then
            v3 = Notifications.AbsolutePosition.Y + Notifications.AbsoluteSize.Y - p2.AbsolutePosition.Y;

            for _, v in { "EscapeStreak", "ChoiceAnnouncement" } do
                local v4 = Notifications:FindFirstChild(v);

                if v4 and v4.Visible then
                    v3 = math.max(v3, v4.AbsolutePosition.Y + v4.AbsoluteSize.Y - p2.AbsolutePosition.Y);
                end;
            end;
        else
            v3 = 16;
        end;

        return v3 + 8;
    end
};