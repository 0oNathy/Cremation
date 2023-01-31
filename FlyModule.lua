
local UIS = game:GetService("UserInputService")
local OnRender = game:GetService("RunService").RenderStepped

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Camera = workspace.CurrentCamera
local Root = Character:WaitForChild("HumanoidRootPart")

local C1, C2, C3;
local CremationFly = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
C1 = UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        if Input.KeyCode == _G.Key then
            CremationFly.Flying = not CremationFly.Flying
            Root.Anchored = CremationFly.Flying
        elseif Input.KeyCode == Enum.KeyCode.W then
            CremationFly.Forward = true
        elseif Input.KeyCode == Enum.KeyCode.S then
            CremationFly.Backward = true
        elseif Input.KeyCode == Enum.KeyCode.A then
            CremationFly.Left = true
        elseif Input.KeyCode == Enum.KeyCode.D then
            CremationFly.Right = true
        end
    end
end)

C2 = UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        if Input.KeyCode == Enum.KeyCode.W then
            CremationFly.Forward = false
        elseif Input.KeyCode == Enum.KeyCode.S then
            CremationFly.Backward = false
        elseif Input.KeyCode == Enum.KeyCode.A then
            CremationFly.Left = false
        elseif Input.KeyCode == Enum.KeyCode.D then
            CremationFly.Right = false
        end
    end
end)

C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
    if CremationFly.Flying then
        Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
    end
end)

while true do
    local Delta = OnRender:Wait()
    if CremationFly.Flying then
        if CremationFly.Forward then
            Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * _G.Speed))
        end
        if CremationFly.Backward then
            Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * _G.Speed))
        end
        if CremationFly.Left then
            Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * _G.Speed))
        end
        if CremationFly.Right then
            Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * _G.Speed))
        end
    end
end
