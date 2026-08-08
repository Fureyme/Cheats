local character = game:GetService("Players").LocalPlayer.Character
local playerPos = character.HumanoidRootPart
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy

local treesCount = 0
local allSwitch = false
local treeType = "Birch"

for indexRegion, region in pairs(workspace:GetChildren()) do --Пошук регіонів з деревами
	if region.Name == "TreeRegion" and region.ClassName == "Model" then
		for indexTree, tree in pairs(workspace:GetChildren()[indexRegion]:GetChildren()) do --Пошук типа дерева
			if tree.TreeClass.Value == treeType then 
				for indexLog, log in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if log.Name == "WoodSection" and log.ID.Value == 1 then
						print(indexLog)
						print(log.Size.Y)
						print(log.CFrame)
						print("workspace:GetChildren()[" .. indexRegion .. "]:GetChildren()[" .. indexTree .. "].CutEvent")
						treesCount = treesCount + 1
						playerPos.CFrame = log.CFrame
						
						for i = 1, 30 do 
							--Ивент для рубки дерерва
							Event:FireServer(
								workspace:GetChildren()[indexRegion]:GetChildren()[indexTree].CutEvent,
								{
									height = 1, --высота рубки
									faceVector = Vector3.new(-1, 0, 0),
									--character.Tool
									tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
									sectionId = 1, --низ дерерва
									hitPoints = 0.2,
									cooldown = 0.65,
									cuttingClass = "Axe"
								})
							wait(0.5)
						end
					elseif treesCount >= 1 and allSwitch == false then
						return --break для всіх for
					end
				end
			end
		end
	end
end







local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local TargetLog = workspace.LogModels:FindFirstChild("Loose_Birch") -- Вкажіть ваше дерево

if TargetLog and TargetLog:FindFirstChild("WoodSection") then
	local Part = TargetLog.WoodSection
	
	-- 1. Створюємо локальний Dragger (як v_u_12 у коді гри)
	local Dragger = Instance.new("Part")
	Dragger.Size = Vector3.new(1, 1, 1)
	Dragger.Transparency = 1
	Dragger.CanCollide = false
	Dragger.CFrame = Part.CFrame
	Dragger.Parent = workspace

	-- 2. Додаємо BodyPosition для керування фізикою
	local BodyPos = Instance.new("BodyPosition", Dragger)
	BodyPos.MaxForce = Vector3.new(17000, 17000, 17000)
	BodyPos.P = 10000
	BodyPos.D = 800
	BodyPos.Position = Part.Position

	-- 3. Приварюємо дерево до Dragger
	local Weld = Instance.new("Weld", Dragger)
	Weld.Part0 = Dragger
	Weld.Part1 = Part
	Weld.C0 = CFrame.new()
	Weld.C1 = Dragger.CFrame:ToObjectSpace(Part.CFrame)

	-- 4. Запускаем фоновий потік підтримки з'єднання з сервером (раз на 0.5 сек)
	local Dragging = true
	task.spawn(function()
		local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
		while Dragging do
			Event:FireServer(TargetLog)
			task.wait(0.5) -- Обов'язково 0.5 сек, як у скрипті гри!
		end
	end)

	-- 5. Тепер рухаємо BodyPos куди завгодно (наприклад, до себе або на базу)
	for i = 1, 50 do
		BodyPos.Position = Character.HumanoidRootPart.Position + Vector3.new(0, 2, -5)
		task.wait(0.05)
	end

	-- 6. Очищення після завершення
	Dragging = false
	Dragger:Destroy()
end







9,753128051757812

workspace.LogModels.Loose_Birch
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy

Event:FireServer(
	workspace:GetChildren()[31]:GetChildren()[71].CutEvent,
	{
		height = 1,
		faceVector = Vector3.new(-1, 0, 0),
		tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
		sectionId = 1,
		hitPoints = 0.2,
		cooldown = 0.65,
		cuttingClass = "Axe"
	}
)

workspace.LogModels.Loose_Birch
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy

for i = 1, 30 do
	Event:FireServer(
		workspace:GetChildren()[31]:GetChildren()[71].CutEvent,
		{
			height = 1,
			faceVector = Vector3.new(-1, 0, 0),
			tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
			sectionId = 1,
			hitPoints = 0.2,
			cooldown = 0.65,
			cuttingClass = "Axe"
		}
	)
	wait(0.5)
end

wait(10)
for i = 1, 1600 do
	local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
	Event:FireServer(
		workspace.LogModels.Loose_Birch
	)
	task.wait(0.01)
end



local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
Event:FireServer(
	workspace.LogModels.Loose_Birch
)



local function GetNil(Name, DebugId)
	for _, Object in getnilinstances() do
		if Object.Name == Name and Object:GetDebugId() == DebugId then
			return Object
		end
	end
end



local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
Event:FireServer(
	GetNil("CutEvent", "1_1414767"),
	{
		height = 0.74495363235474,
		faceVector = Vector3.new(-1, 0, 0),
		tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
		sectionId = 1,
		hitPoints = 0.2,
		cooldown = 0.65,
		cuttingClass = "Axe"
	}
)




local function GetNil(Name, DebugId)
	for _, Object in getnilinstances() do
		if Object.Name == Name and Object:GetDebugId() == DebugId then
			return Object
		end
	end
end

local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
Event:FireServer(
	GetNil("CutEvent", "1_1414767"),
	{
		height = 0.74495363235474,
		faceVector = Vector3.new(-1, 0, 0),
		tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
		sectionId = 1,
		hitPoints = 0.2,
		cooldown = 0.65,
		cuttingClass = "Axe"
	}
)



local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
Event:FireServer(
	workspace:GetChildren()[31]:GetChildren()[5].CutEvent,
	{
		height = 0.74495363235474,
		faceVector = Vector3.new(-1, 0, 0),
		tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
		sectionId = 1,
		hitPoints = 0.2,
		cooldown = 0.65,
		cuttingClass = "Axe"
	}
)


getgenv().LDKey = "LD26557457108718"

loadstring(game:HttpGet([[https://raw.githubusercontent.com/kode-sec/Butter/refs/heads/main/main.lua]]))()