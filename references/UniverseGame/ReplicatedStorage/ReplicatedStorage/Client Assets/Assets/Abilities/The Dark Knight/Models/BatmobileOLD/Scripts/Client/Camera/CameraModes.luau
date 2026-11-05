  

 

local Chassis = script.Parent.Parent.Parent.Parent.Chassis;

return {
    {
        module = "ChaseCamera",
        parameters = {
            height = 7,
            distance = 15
        }
    },
    {
        module = "ChaseCamera",
        parameters = {
            height = 9,
            distance = 25
        }
    },
    {
        module = "InteriorCamera",
        parameters = {
            forwardHeadTurnAngle = 0.3490658503988659,
            reverseHeadTurnAngle = -2.443460952792061,
            attachment = Chassis.InteriorCameraAttachment
        }
    },
    {
        module = "FixedCamera",
        parameters = {
            attachment = Chassis.HoodCameraAttachment
        }
    }
};