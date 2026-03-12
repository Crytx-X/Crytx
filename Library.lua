local Globals = getgenv()
if not game:IsLoaded() then game.Loaded:Wait() end

-- =====================================================================
-- // SERVICES & MAIN REFERENCES
-- =====================================================================
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathfindingService = game:GetService("PathfindingService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local PlayersService = game:GetService("Players")

local RemoteFunc = ReplicatedStorage:WaitForChild("RemoteFunction")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")

local LocalPlayer = PlayersService.LocalPlayer or PlayersService.PlayerAdded:Wait()
local mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FileName = "ADS_Config.json"

local SendRequest = request or http_request or httprequest or (GetDevice and GetDevice().request)
if not SendRequest then warn("Aether Hub: No HTTP function found.") return end

-- =====================================================================
-- // DATA & CONFIGURATIONS
-- =====================================================================
local TowerSkins = {
    ["Accelerator"] = {["Champion"]="90324305122544", ["Cupid"]="16742017040", ["Dank"]="18549604688", ["Default"]="16742017289", ["Disco"]="96135720673651", ["Ducky"]="16742017439", ["Eclipse"]="16742017644", ["Elite"]="16742017935", ["Fallen"]="18848269402", ["Ghost Buster"]="16742018196", ["Ice Witch"]="16742018426", ["Legend"]="16742018621", ["Mage"]="16742018781", ["Magician"]="104973122569052", ["Navy"]="16742018971", ["Nuclear"]="16742019185", ["Octopus"]="138359133170089", ["Patient Zero"]="88972169285855", ["Plushie"]="16742019393", ["Red"]="16742019754", ["Senator"]="17363277841", ["Speaker Titan"]="16997023622", ["Vigilante"]="16742019956"},
    ["Ace Pilot"] = {["Aerial Ace"]="17859245825", ["Default"]="17859246260", ["Easter"]="137734270861409", ["Green"]="17859246778", ["Navy"]="17859247163", ["Pumpkin"]="17859247510", ["Purple"]="17859247791", ["Red"]="17859248266", ["Toy Plane"]="90411909913759", ["Yellow"]="17859248807"},
    ["Archer"] = {["Default"]="102469025012991", ["Elf"]="118017603574255", ["Huntsman"]="108057864574863", ["Ice Soul"]="125693199171973", ["Spooky"]="109768712967611", ["Valentines"]="88010001274532"},
    ["Assassin"] = {["Actor"]="112178399627918", ["Default"]="117970650222627", ["Saber Tooth Tiger"]="129525356172974"},
    ["Biologist"] = {["Default"]="101795075923269", ["Grim"]="126912872410229"},
    ["Brawler"] = {["Banned"]="84628371320634", ["Blazing"]="18549605468", ["Default"]="17506304027", ["Fallen"]="18835925180", ["Horse"]="101555481625059", ["Jordan"]="70748904383488", ["Loader"]="131316320823683", ["Lobster"]="123985511698683", ["Lovestriker"]="83049730035300", ["Rudolph"]="122757939585280", ["Werewolf"]="105319960862894"},
    ["Commander"] = {["Aqua"]="89379123461384", ["Bloxy"]="16742023051", ["Brisk"]="16742023299", ["Bunny"]="17507647451", ["Candy Cane"]="115979067743950", ["Default"]="17507647561", ["Director"]="140380406065215", ["Ducky"]="16742023989", ["Eclipse"]="16742024255", ["Eggrypted"]="16742024613", ["Fallen"]="80567934657980", ["Frost"]="16742024893", ["Galactic"]="17507647660", ["Gargoyle"]="17507647804", ["General"]="17507647965", ["Ghost"]="17507648068", ["Green"]="17507648232", ["Holiday"]="16742026260", ["Lifeguard"]="16742026508", ["Maid"]="17507648382", ["Neko"]="17507648601", ["Patriotic"]="18323544710", ["Pattern"]="17507648760", ["Phantom"]="16742027114", ["Pirate"]="16742027462", ["Plushie"]="16742027624", ["Red"]="17507648923", ["Santa"]="117501182181139", ["Spring Time"]="17507649066", ["Umbra"]="16742028241", ["Valentines"]="16742028419", ["Victorian"]="17507649166", ["Vigilante"]="17507649270", ["War Lord"]="16742028910", ["Wasteland"]="93243165798255", ["Werewolf"]="110092626333388", ["Wonderland"]="86397469450446"},
    ["Cowboy"] = {["Agent"]="16742029625", ["Badlands"]="16742029785", ["Bandit"]="16742029974", ["Bounty Hunter"]="16742030178", ["Cop"]="16742030440", ["Cyberpunk"]="16742030746", ["Dark Frost"]="78872525322359", ["Default"]="16742031062", ["Ducky"]="16742031273", ["Fallen"]="18848220133", ["Golden"]="16742031462", ["Holiday"]="16742031725", ["Kasodus"]="16742031988", ["Masquerade"]="16742032218", ["Mecha Bunny"]="70870846433248", ["Megalodon"]="129525988654572", ["Noir"]="16742032406", ["Plushie"]="84617405752906", ["Pumpkin"]="16742032605", ["Redemption"]="16742032735", ["Retired"]="16742032911", ["Spring Time"]="127656855808415", ["Valentines"]="16742033284", ["Vampire Hunter"]="99306749260135"},
    ["Crook Boss"] = {["Alien Focus"]="133134889361359", ["Assassin"]="16742033599", ["Blue"]="16742033877", ["Checker"]="16742034068", ["Corso"]="16742034286", ["Cupid"]="16742034551", ["Cybernetic"]="16996940813", ["DRKSHDW"]="16742034843", ["Dark Frost"]="125130339305089", ["Default"]="16742035067", ["Demon"]="16742035383", ["Easter"]="101408307745429", ["Game Master"]="75261782948960", ["Golden"]="16742035712", ["Holiday"]="16742036050", ["Intern"]="16742036260", ["Narrator"]="92111450115834", ["Necromancer"]="16742036503", ["Null"]="102269930328399", ["Pirate"]="16742036700", ["Rat King"]="99680623337214", ["Red"]="16742036972", ["Soviet"]="17363278550", ["Spooky"]="16742037577", ["SteamPunk"]="16742037752", ["Victorian"]="95810120766308", ["Xmas"]="16742038000"},
    ["DJ Booth"] = {["Default"]="90127560097295", ["Ducky"]="108324875176244", ["Garage Band"]="102404432745932", ["Ghost"]="111981689753740", ["Gingerbread"]="88595674290447", ["Mako"]="105492996309734", ["Masquerade"]="16742060736", ["Neko"]="115310627249069", ["Neon Rave"]="88395223637973", ["Plushie"]="16742061708", ["Seal"]="124438946534088"},
    ["Farm"] = {["Arcade"]="16742069471", ["Booth"]="114387520669997", ["Cinema"]="113467369649039", ["Cozy Camp"]="140408163540785", ["Crab"]="80117562627776", ["Crypto"]="16742069733", ["Cube"]="80832036812275", ["Default"]="16742069981", ["Ducky"]="16742070242", ["Graveyard"]="16742070511", ["Lemonade Stand"]="81915340530819", ["Null Soul"]="81613076972732", ["PNG"]="102229660485968", ["Pirate"]="16742070778", ["Present"]="16742071112", ["Tycoon"]="16742071421", ["Vendor"]="16742071670", ["Wasteland"]="115389901462450", ["Xmas"]="16742072101"},
    ["Minigunner"] = {["Beach"]="16742103082", ["Black Ops"]="16742103323", ["Blue"]="16742103560", ["Bunny"]="16742103808", ["Chad"]="16997025666", ["Chocolatier"]="123838075161800", ["Community"]="16742104107", ["Crusader"]="16742104409", ["Cursed"]="120591121926081", ["Default"]="16742104678", ["Ducky"]="16742104895", ["Fallen"]="18739982182", ["Frost"]="16742105137", ["Gardener"]="82544636570442", ["Ghost"]="16742105452", ["Golden"]="16742105731", ["Golden Plushie"]="18563673298", ["Green"]="16742105989", ["Hazmat"]="16742106200", ["Heavy"]="16742106470", ["Holiday"]="16742106731", ["Nutcracker"]="123307115343441", ["Ox"]="74202120404385", ["Party"]="16742106926", ["Phantom"]="16742107196", ["Plushie"]="16742107455", ["Pumpkin"]="16742107785", ["Road Rage"]="127265987839477", ["Space Elite"]="16742108056", ["Sweaking"]="16742108280", ["Toy"]="16742108498", ["Trucker"]="16997026080", ["Twitter"]="16742108697", ["Warlord"]="16742108927", ["Wraith"]="16742109128", ["Xmas"]="16742109340"},
    ["Ranger"] = {["5ouls"]="18549607210", ["Badlands"]="16801603418", ["Beast Slayer"]="16742130037", ["Black Ops"]="16742130258", ["Blue"]="16742130444", ["Bunny"]="16742130675", ["Classic"]="16742130816", ["Dark Matter"]="16742131006", ["Default"]="16742131160", ["Eclipse"]="16742131402", ["Eskimo"]="128714714796489", ["Frankenstein"]="123830216490388", ["Frost"]="16742131549", ["Green"]="16742131725", ["Gun Gale"]="16742131902", ["Mecha Ducky"]="111106612615105", ["Partisan"]="16742132072", ["Phantom"]="16742132284", ["Propellars"]="16742132454", ["Pumpkin"]="16742048328", ["Railgunner"]="16742132622", ["Shark"]="118641195806072", ["SteamPunk"]="17766383629", ["Valentines"]="16742132842", ["Wraith"]="16742133100"},
    ["Scout"] = {["Banned"]="98679998862541", ["Beach"]="16742135002", ["Black Ops"]="16742135175", ["Blue"]="16742135394", ["Bunny"]="16742135669", ["Cookie"]="16742135838", ["Default"]="16742136020", ["Ducky"]="16742136236", ["Eclipse"]="16742136452", ["Fallen"]="18739982633", ["Frost Hunter"]="16742136608", ["Golden"]="16742136768", ["Green"]="16742136919", ["Guest"]="17571579155", ["Haz3mn"]="130252324129434", ["Holiday"]="16742137176", ["Intern"]="16742137311", ["King of Rock"]="117402710044000", ["Masquerade"]="16742137522", ["Party"]="16742137715", ["Penguin"]="102209448087896", ["Phantom"]="16742137918", ["Plushie"]="16742138111", ["Prime Raven"]="16742138286", ["Red"]="16742138539", ["Shark"]="89854318503673", ["Skull Trooper"]="16742138815", ["Survivor"]="16742139178", ["Toilet"]="16997026586", ["Valentines"]="16742139334", ["Valhalla"]="16742139584"}
}

-- Mengubah ID Menjadi Format Roblox Asset URL
for towerName, skins in pairs(TowerSkins) do
    for skinName, id in pairs(skins) do
        TowerSkins[towerName][skinName] = "rbxassetid://" .. id
    end
end

local ValidTowersList = {
    "Scout","Sniper","Paintballer","Demoman","Hunter","Soldier","Militant",
    "Freezer","Assassin","Shotgunner","Pyromancer","Ace Pilot","Medic","Farm",
    "Rocketeer","Trapper","Military Base","Crook Boss",
    "Electroshocker","Commander","Warden","Cowboy","DJ Booth","Minigunner",
    "Ranger","Pursuit","Gatling Gun","Turret","Mortar","Mercenary Base",
    "Brawler","Necromancer","Accelerator","Engineer","Hacker",
    "Gladiator","Commando","Slasher","Frost Blaster","Archer","Swarmer",
    "Toxic Gunner","Sledger","Executioner","Elf Camp","Jester","Cryomancer",
    "Hallow Punk","Harvester","Snowballer","Elementalist",
    "Firework Technician","Biologist","Warlock","Spotlight Tech","Mecha Base"
}

local AllModifiers = {
    "HiddenEnemies", "Glass", "ExplodingEnemies", "Limitation", 
    "Committed", "HealthyEnemies", "Fog", "FlyingEnemies", 
    "Broke", "SpeedyEnemies", "Quarantine", "JailedTowers", "Inflation"
}

local DefaultSettings = {
    PathVisuals = false, MilitaryPath = false, MercenaryPath = false,
    AutoSkip = false, AutoChain = false, SupportCaravan = false,
    AutoDJ = false, AutoNecro = false, AutoRejoin = true,
    TimeScaleEnabled = false, TimeScaleValue = 2, SellFarms = false,
    AutoMercenary = false, AutoMilitary = false, Frost = false,
    Fallen = false, Easy = false, AntiLag = false, Disable3DRendering = false,
    AutoPickups = false, ClaimRewards = false, SendWebhook = false,
    NoRecoil = false, SellFarmsWave = 1, WebhookURL = "",
    Cooldown = 0.01, Multiply = 1, AutoCooldown = 0.01, AutoMultiply = 1,
    AutoGatling = false, TargetChamsEnabled = false, TargetChamsType = "Highlight",
    PickupMethod = "Pathfinding", StreamerMode = false, HideUsername = false,
    StreamerName = "", tagName = "None", Modifiers = {}, SilentAimEnabled = false,
    TargetPriority = "First", AutoGatlingPriority = "First", EnemyTracker = false
}

local ItemNames = {
    ["17447507910"] = "Timescale Ticket(s)", ["17438486690"] = "Range Flag(s)",
    ["17438486138"] = "Damage Flag(s)", ["17438487774"] = "Cooldown Flag(s)",
    ["17429537022"] = "Blizzard(s)", ["17448596749"] = "Napalm Strike(s)",
    ["18493073533"] = "Spin Ticket(s)", ["17429548305"] = "Supply Drop(s)",
    ["18443277308"] = "Low Grade Crate(s)", ["18443277106"] = "Mid Grade Crate(s)",
    ["18443277591"] = "High Grade Crate(s)", ["110415073436604"] = "Holy Hand Grenade(s)",
    ["17429533728"] = "Frag Grenade(s)", ["17437703262"] = "Molotov(s)"
}

-- =====================================================================
-- // CORE UTILITIES & AFK HANDLER
-- =====================================================================
local function IdentifyGameState()
    local TempGui = LocalPlayer:WaitForChild("PlayerGui")
    while true do
        if TempGui:FindFirstChild("ReactLobbyHud") then return "LOBBY"
        elseif TempGui:FindFirstChild("ReactUniversalHotbar") then return "GAME" end
        task.wait(1)
    end
end
local GameState = IdentifyGameState()

task.spawn(function()
    local success, connections = pcall(getconnections, LocalPlayer.Idled)
    if success then for _, v in pairs(connections) do v:Disable() end end
    
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
    
    local overlay = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
    overlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' then
            while true do TeleportService:Teleport(3260590327); task.wait(5) end
        end
    end)
    
    if GameState == "LOBBY" then
        local LobbyTimer = 0
        while GameState == "LOBBY" do 
            task.wait(1)
            LobbyTimer += 1
            if LobbyTimer >= 600 then TeleportService:Teleport(3260590327); break end
        end
    end
end)

local function SaveSettings()
    local DataToSave = {}
    for key, _ in pairs(DefaultSettings) do DataToSave[key] = Globals[key] end
    writefile(FileName, HttpService:JSONEncode(DataToSave))
end

local function LoadSettings()
    if isfile(FileName) then
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(FileName)) end)
        if success and type(data) == "table" then
            for key, DefaultVal in pairs(DefaultSettings) do
                Globals[key] = data[key] ~= nil and data[key] or DefaultVal
            end
            return
        end
    end
    for key, value in pairs(DefaultSettings) do Globals[key] = value end
    SaveSettings()
end

local function SetSetting(name, value)
    if DefaultSettings[name] ~= nil then
        Globals[name] = value
        SaveSettings()
    end
end

LoadSettings()

local function Apply3dRendering()
    RunService:Set3dRenderingEnabled(not Globals.Disable3DRendering)
    local gui = PlayerGui:FindFirstChild("ADS_BlackScreen")
    if Globals.Disable3DRendering then
        if not gui then
            gui = Instance.new("ScreenGui", PlayerGui)
            gui.Name = "ADS_BlackScreen"
            gui.IgnoreGuiInset = true; gui.DisplayOrder = -1000
            local frame = Instance.new("Frame", gui)
            frame.BackgroundColor3 = Color3.new(0,0,0)
            frame.Size = UDim2.fromScale(1, 1)
        end
        gui.Enabled = true
    else
        if gui then gui.Enabled = false end
    end
end
Apply3dRendering()

-- =====================================================================
-- // PRIVACY & STREAMER MODE
-- =====================================================================
local OriginalDisplayName = LocalPlayer.DisplayName
local OriginalUserName = LocalPlayer.Name
local SpoofTextCache = setmetatable({}, {__mode = "k"})

local function ReplaceText(inst, newName)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    local txt = inst.Text
    if type(txt) == "string" and txt ~= "" then
        local t, changed = txt, false
        if OriginalDisplayName and string.find(t, OriginalDisplayName, 1, true) then
            t = string.gsub(t, OriginalDisplayName, newName); changed = true
        end
        if OriginalUserName and string.find(t, OriginalUserName, 1, true) then
            t = string.gsub(t, OriginalUserName, newName); changed = true
        end
        if changed then
            if not SpoofTextCache[inst] then SpoofTextCache[inst] = txt end
            inst.Text = t
        end
    end
end

local function UpdatePrivacyState()
    local nm = (Globals.StreamerMode and (Globals.StreamerName ~= "" and Globals.StreamerName or "SpoofedUser")) or (Globals.HideUsername and "████████") or nil
    if nm then
        pcall(function() LocalPlayer.DisplayName = nm end)
        for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do ReplaceText(obj, nm) end
        for _, obj in ipairs(PlayerGui:GetDescendants()) do ReplaceText(obj, nm) end
    else
        pcall(function() LocalPlayer.DisplayName = OriginalDisplayName end)
        for inst, originalTxt in pairs(SpoofTextCache) do
            if inst and inst.Parent then pcall(function() inst.Text = originalTxt end) end
        end
        SpoofTextCache = {}
    end
end
task.spawn(function() while true do UpdatePrivacyState(); task.wait(2) end end)

-- =====================================================================
-- // RADAR & ESP (SILENT AIM / AUTOGATLING)
-- =====================================================================
Globals.CurrentTargetModel = nil
Globals.CurrentHighlight = nil
Globals.LockedTargetPosition = nil

local function ClearESP()
    if Globals.CurrentHighlight then Globals.CurrentHighlight:Destroy(); Globals.CurrentHighlight = nil end
    Globals.CurrentTargetModel = nil
end

local function ApplyTargetChams(enemyModel)
    if not enemyModel then ClearESP(); return end
    if Globals.CurrentTargetModel ~= enemyModel then
        ClearESP()
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Adornee = enemyModel
        highlight.Parent = game:GetService("CoreGui") 
        Globals.CurrentHighlight = highlight
        Globals.CurrentTargetModel = enemyModel
    end
end

local function CreateTracer(targetPos)
    local startPos = nil
    local towersFolder = workspace:FindFirstChild("Towers")
    if towersFolder then
        for _, tower in pairs(towersFolder:GetChildren()) do
            local rep = tower:FindFirstChild("TowerReplicator")
            if rep and rep:GetAttribute("OwnerId") == LocalPlayer.UserId and rep:GetAttribute("Name") == "Gatling Gun" then
                startPos = tower.PrimaryPart and tower.PrimaryPart.Position or nil; break
            end
        end
    end
    if not startPos then return end

    local tracer = Instance.new("Part")
    tracer.Anchored, tracer.CanCollide, tracer.Material = true, false, Enum.Material.Neon
    tracer.Color = Color3.fromRGB(255, 200, 50)
    local distance = (targetPos - startPos).Magnitude
    tracer.Size = Vector3.new(0.15, 0.15, distance) 
    tracer.CFrame = CFrame.lookAt(startPos, targetPos) * CFrame.new(0, 0, -(distance / 2))
    tracer.Parent = workspace.Terrain
    TweenService:Create(tracer, TweenInfo.new(0.15), {Transparency = 1}):Play()
    game:GetService("Debris"):AddItem(tracer, 0.15)
end

RunService.Heartbeat:Connect(function()
    if not Globals.AutoGatling and not Globals.SilentAimEnabled then
        ClearESP(); Globals.LockedTargetPosition = nil; return
    end

    local towerPos = workspace.CurrentCamera.CFrame.Position
    local BestTargetEnemy, TargetHitbox = nil, nil
    local MaxDistance, MaxHealth, MinDist, MinDistancePath = -1, -1, math.huge, math.huge
    local activePriority = Globals.AutoGatling and Globals.AutoGatlingPriority or Globals.TargetPriority

    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, enemy in pairs(npcs:GetChildren()) do
            local hitbox = enemy:FindFirstChild("HumanoidRootPart")
            local pointer = enemy:FindFirstChild("RootPointer") 
            
            if hitbox and pointer and pointer.Value then
                local health = pointer.Value:GetAttribute("Health") or 0
                local pathDist = pointer.Value:GetAttribute("PathDistance") or 0
                
                if health > 0 then
                    if activePriority == "First" and pathDist > MaxDistance then
                        MaxDistance = pathDist; BestTargetEnemy = enemy; TargetHitbox = hitbox
                    elseif activePriority == "Last" and pathDist < MinDistancePath then
                        MinDistancePath = pathDist; BestTargetEnemy = enemy; TargetHitbox = hitbox
                    elseif activePriority == "Strongest" and health > MaxHealth then
                        MaxHealth = health; BestTargetEnemy = enemy; TargetHitbox = hitbox
                    elseif activePriority == "Close" then
                        local dist = (hitbox.Position - towerPos).Magnitude
                        if dist < MinDist then MinDist = dist; BestTargetEnemy = enemy; TargetHitbox = hitbox end
                    end
                end
            end
        end
    end

    Globals.LockedTargetPosition = TargetHitbox and TargetHitbox.Position or nil

    if BestTargetEnemy and Globals.TargetChamsEnabled and (Globals.TargetChamsType == "Highlight" or Globals.TargetChamsType == "Both") then
        ApplyTargetChams(BestTargetEnemy)
    else
        ClearESP()
    end
end)

if hookmetamethod then
    local lastTracerTime = 0
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if method == "FireServer" and typeof(self) == "Instance" and self.Name == "RE:Fire" then
            if self.Parent and self.Parent.Name == "GatlingGun" and (Globals.AutoGatling or Globals.SilentAimEnabled) and Globals.TargetChamsEnabled and (Globals.TargetChamsType == "Tracer" or Globals.TargetChamsType == "Both") then
                local args = {...}
                if typeof(args[1]) == "Vector3" and os.clock() - lastTracerTime >= 0.05 then 
                    lastTracerTime = os.clock()
                    task.spawn(CreateTracer, args[1])
                end
            end
        end

        if method == "InvokeServer" and typeof(self) == "Instance" and self.Name == "RemoteFunction" then
            local args = {...}
            if args[1] == "Troops" and args[2] == "Abilities" and args[3] == "Activate" then
                local payload = args[4]
                if type(payload) == "table" and payload.Name == "FPS" and payload.Data and payload.Data.enabled == false then
                    if Globals.AutoGatling then
                        args[4] = { Troop = payload.Troop, Name = payload.Name, Data = { enabled = true } }
                        return oldNamecall(self, unpack(args))
                    end
                end
            end
        end
        return oldNamecall(self, ...)
    end)
end

-- =====================================================================
-- // TDS API & TOWER LOGIC
-- =====================================================================
local TDS = {
    PlacedTowers = {}, ActiveStrat = true,
    MatchmakingMap = {["Hardcore"]="hardcore", ["Pizza Party"]="halloween", ["Badlands"]="badlands", ["Polluted"]="polluted"}
}
shared.TDSTable = TDS; shared["TDS_Table"] = TDS

function TDS:Equip(tower_name)
    local success, _ = pcall(function() return RemoteFunc:InvokeServer("Inventory", "Equip", "tower", tower_name) end)
    return success
end

function TDS:Unequip(tower_name)
    local success, _ = pcall(function() return RemoteFunc:InvokeServer("Inventory", "Unequip", "tower", tower_name) end)
    return success
end

local function GetEquippedTowers()
    local towers = {}
    local StateReplicators = ReplicatedStorage:FindFirstChild("StateReplicators")
    if StateReplicators then
        for _, folder in ipairs(StateReplicators:GetChildren()) do
            if folder.Name == "PlayerReplicator" and folder:GetAttribute("UserId") == LocalPlayer.UserId then
                local equipped = folder:GetAttribute("EquippedTowers")
                if type(equipped) == "string" then
                    local success, TowerTable = pcall(function() return HttpService:JSONDecode(equipped:match("%[.*%]")) end)
                    if success and type(TowerTable) == "table" then
                        for i = 1, 5 do if TowerTable[i] then table.insert(towers, TowerTable[i]) end end
                    end
                end
            end
        end
    end
    return #towers > 0 and towers or {"None"}
end

local CurrentEquippedTowers = GetEquippedTowers()
local StackEnabled, SelectedTower, StackSphere = false, nil, nil

-- =====================================================================
-- // UI CREATION (AETHER HUB)
-- =====================================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/UI.lua"))()

local Window = Library:Window({
    Title = "Aether Hub",
    Desc = "Your #1 TDS Hub (Premium Optimized)",
    Theme = "Dark",
    DiscordLink = "https://discord.gg/autostrat",
    Icon = 126403638319957,
    Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0, 500, 0, 400) }
})

-- // TAB 1: AUTOSTRAT
local Autostrat = Window:Tab({Title = "Autostrat", Icon = "star"}) do
    Autostrat:Section({Title = "Main"})
    Autostrat:Toggle({Title = "Auto Rejoin", Value = Globals.AutoRejoin, Callback = function(v) SetSetting("AutoRejoin", v) end})
    Autostrat:Toggle({Title = "Auto Skip Waves", Value = Globals.AutoSkip, Callback = function(v) SetSetting("AutoSkip", v) end})
    Autostrat:Toggle({Title = "Auto Chain (Commander)", Value = Globals.AutoChain, Callback = function(v) SetSetting("AutoChain", v) end})
    Autostrat:Toggle({Title = "Auto DJ Booth", Value = Globals.AutoDJ, Callback = function(v) SetSetting("AutoDJ", v) end})
    Autostrat:Toggle({Title = "Auto Necromancer", Value = Globals.AutoNecro, Callback = function(v) SetSetting("AutoNecro", v) end})
    
    Autostrat:Section({Title = "TimeScale"})
    Autostrat:Toggle({Title = "Enable TimeScale", Value = Globals.TimeScaleEnabled, Callback = function(v) SetSetting("TimeScaleEnabled", v) end})
    Autostrat:Dropdown({Title = "TimeScale Speed", List = {"0.5", "1", "1.5", "2"}, Value = tostring(Globals.TimeScaleValue), Callback = function(c) SetSetting("TimeScaleValue", tonumber(type(c)=="table" and c[1] or c) or 2) end})
    
    Autostrat:Section({Title = "Farm"})
    Autostrat:Toggle({Title = "Sell Farms", Value = Globals.SellFarms, Callback = function(v) SetSetting("SellFarms", v) end})
    Autostrat:Textbox({Title = "Wave:", Placeholder = "40", Value = tostring(Globals.SellFarmsWave), Callback = function(t) SetSetting("SellFarmsWave", tonumber(t) or 40) end})
    
    Autostrat:Section({Title = "Abilities (Base)"})
    Autostrat:Toggle({Title = "Auto Mercenary Base", Value = Globals.AutoMercenary, Callback = function(v) SetSetting("AutoMercenary", v) end})
    Autostrat:Slider({Title = "Mercenary Path Dist", Min = 0, Max = 300, Value = Globals.MercenaryPath, Callback = function(v) SetSetting("MercenaryPath", v) end})
    Autostrat:Toggle({Title = "Auto Military Base", Value = Globals.AutoMilitary, Callback = function(v) SetSetting("AutoMilitary", v) end})
    Autostrat:Slider({Title = "Military Path Dist", Min = 0, Max = 300, Value = Globals.MilitaryPath, Callback = function(v) SetSetting("MilitaryPath", v) end})
end

Window:Line()

-- // TAB 2: MAIN
local Main = Window:Tab({Title = "Main", Icon = "stamp"}) do
    Main:Section({Title = "Tower Controls"})
    local TowerDropdown = Main:Dropdown({Title = "Tower:", List = CurrentEquippedTowers, Value = CurrentEquippedTowers[1], Callback = function(c) SelectedTower = c end})
    
    task.spawn(function()
        while task.wait(2) do
            local NewTowers = GetEquippedTowers()
            if table.concat(NewTowers, ",") ~= table.concat(CurrentEquippedTowers, ",") then
                TowerDropdown:Clear()
                for _, t in ipairs(NewTowers) do TowerDropdown:Add(t) end
                CurrentEquippedTowers = NewTowers
            end
        end
    end)

    Main:Toggle({Title = "Stack Tower (Placement)", Value = false, Callback = function(v) StackEnabled = v end})
    Main:Button({Title = "Upgrade All Towers", Callback = function()
        for _, v in pairs(workspace.Towers:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer.UserId then
                RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = v})
            end
        end
        Window:Notify({Title = "ADS", Desc = "Attempted to upgrade all towers!", Time = 3})
    end})
    Main:Button({Title = "Sell All Towers", Callback = function()
        for _, v in pairs(workspace.Towers:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer.UserId then
                RemoteFunc:InvokeServer("Troops", "Sell", {Troop = v})
            end
        end
        Window:Notify({Title = "ADS", Desc = "Attempted to sell all towers!", Time = 3})
    end})

    Main:Section({Title = "Equipper"})
    Main:Textbox({Title = "Equip Tower:", Placeholder = "E.g. Gatling Gun", Callback = function(t) TDS:Equip(t) end})
    Main:Textbox({Title = "Unequip Tower:", Placeholder = "E.g. Farm", Callback = function(t) TDS:Unequip(t) end})
    
    Main:Section({Title = "Stats Tracker"})
    local CoinsLabel = Main:Label({Title = "Coins: 0"})
    local GemsLabel = Main:Label({Title = "Gems: 0"})
    local LevelLabel = Main:Label({Title = "Level: 0"})
    
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                local coins = LocalPlayer:FindFirstChild("Coins") and LocalPlayer.Coins.Value or 0
                local gems = LocalPlayer:FindFirstChild("Gems") and LocalPlayer.Gems.Value or 0
                local lvl = LocalPlayer:FindFirstChild("Level") and LocalPlayer.Level.Value or 0
                CoinsLabel:SetTitle("Coins: " .. tostring(coins))
                GemsLabel:SetTitle("Gems: " .. tostring(gems))
                LevelLabel:SetTitle("Level: " .. tostring(lvl))
            end)
        end
    end)
end

Window:Line()

-- // TAB 3: STRATEGIES
local Strategies = Window:Tab({Title = "Strategies", Icon = "newspaper"}) do
    local function LoadStrat(url)
        task.spawn(function()
            local content = game:HttpGet(url)
            while not (TDS and TDS.Loadout) do task.wait(0.5) end
            local func = loadstring(content)
            if func then func(); Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 }) end
        end)
    end

    Strategies:Section({Title = "Survival Strategies"})
    Strategies:Toggle({Title = "Frost Mode", Value = Globals.Frost, Callback = function(v) SetSetting("Frost", v); if v then LoadStrat("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Frost.lua") end end})
    Strategies:Toggle({Title = "Fallen Mode", Value = Globals.Fallen, Callback = function(v) SetSetting("Fallen", v); if v then LoadStrat("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Fallen.lua") end end})
    Strategies:Toggle({Title = "Intermediate Mode", Value = Globals.Intermediate, Callback = function(v) SetSetting("Intermediate", v); if v then LoadStrat("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Intermediate.lua") end end})
    Strategies:Toggle({Title = "Easy Mode", Value = Globals.Easy, Callback = function(v) SetSetting("Easy", v); if v then LoadStrat("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Easy.lua") end end})
    Strategies:Toggle({Title = "Hardcore Mode", Value = Globals.Hardcore, Callback = function(v) SetSetting("Hardcore", v); if v then LoadStrat("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Hardcore.lua") end end})
end

Window:Line()

-- // TAB 4: MISC & PREMIUM
local Misc = Window:Tab({Title = "Misc", Icon = "box"}) do
    Misc:Section({Title = "Performance"})
    Misc:Toggle({Title = "Enable Anti-Lag", Value = Globals.AntiLag, Callback = function(v) SetSetting("AntiLag", v) end})
    Misc:Toggle({Title = "Disable 3D Rendering", Value = Globals.Disable3DRendering, Callback = function(v) SetSetting("Disable3DRendering", v); Apply3dRendering() end})

    Misc:Section({Title = "Automation"})
    Misc:Toggle({Title = "Auto Collect Pickups", Value = Globals.AutoPickups, Callback = function(v) SetSetting("AutoPickups", v) end})
    Misc:Toggle({Title = "Claim Lobby Rewards", Value = Globals.ClaimRewards, Callback = function(v) SetSetting("ClaimRewards", v) end})
    Misc:Button({Title = "Open Inventory (Force)", Callback = function()
        pcall(function() require(ReplicatedStorage.Shared.Modules.NewNetwork).Channel("Inventory"):fireUnreliableServer("OpenInventory") end)
        for _, m in ipairs(getloadedmodules()) do
            if m.Name == "View" and m.Parent and m.Parent.Name == "Stores" then require(m):commit("setView", "Inventory"); break end
        end
    end})

    Misc:Section({Title = "Advanced ESP & Radar"})
    Misc:Toggle({Title = "Enable Advanced Enemy Tracker UI", Value = Globals.EnemyTracker, Callback = function(v) SetSetting("EnemyTracker", v) end})
    Misc:Toggle({Title = "Enable Target Visual (ESP/Tracer)", Value = Globals.TargetChamsEnabled, Callback = function(v) SetSetting("TargetChamsEnabled", v); if not v then ClearESP() end end})
    Misc:Dropdown({Title = "Target Visual Type", List = {"Highlight", "Tracer", "Both"}, Value = Globals.TargetChamsType, Callback = function(c) SetSetting("TargetChamsType", type(c)=="table" and c[1] or c) end})

    Misc:Section({Title = "Auto Gatling & Silent Aim"})
    Misc:Toggle({Title = "Enable Auto Gatling", Value = Globals.AutoGatling, Callback = function(v) SetSetting("AutoGatling", v) end})
    Misc:Dropdown({Title = "Target Priority", List = {"First", "Last", "Strongest", "Close"}, Value = Globals.AutoGatlingPriority, Callback = function(c) SetSetting("AutoGatlingPriority", type(c)=="table" and c[1] or c) end})
    Misc:Toggle({Title = "Enable Silent Aim", Value = Globals.SilentAimEnabled, Callback = function(v) SetSetting("SilentAimEnabled", v); if not v then ClearESP() end end})
end

Window:Line()

-- // TAB 5: LOGGER
local LoggerTab = Window:Tab({Title = "Logger", Icon = "notebook-pen"})
local Logger = LoggerTab:CreateLogger({Title = "STRATEGY LOGGER:", Size = UDim2.new(0, 330, 0, 300)})

Window:Line()

-- // TAB 6: SETTINGS
local Settings = Window:Tab({Title = "Settings", Icon = "settings"}) do
    Settings:Section({Title = "Config Management"})
    Settings:Button({Title = "Save Settings", Callback = function() SaveSettings(); Window:Notify({Title="Success", Desc="Settings Saved", Time=3}) end})
    Settings:Button({Title = "Load Settings", Callback = function() LoadSettings(); Window:Notify({Title="Success", Desc="Settings Loaded", Time=3}) end})

    Settings:Section({Title = "Privacy"})
    Settings:Toggle({Title = "Hide Username", Value = Globals.HideUsername, Callback = function(v) SetSetting("HideUsername", v); UpdatePrivacyState() end})
    Settings:Toggle({Title = "Streamer Mode", Value = Globals.StreamerMode, Callback = function(v) SetSetting("StreamerMode", v); UpdatePrivacyState() end})
    Settings:Textbox({Title = "Streamer Name", Placeholder = "Spoofed Name", Value = Globals.StreamerName, Callback = function(v) SetSetting("StreamerName", v); UpdatePrivacyState() end})

    Settings:Section({Title = "Discord Webhook"})
    Settings:Toggle({Title = "Send Webhook Logs", Value = Globals.SendWebhook, Callback = function(v) SetSetting("SendWebhook", v) end})
    Settings:Textbox({Title = "Webhook URL:", Placeholder = "https://discord.com/api/webhooks/...", Value = Globals.WebhookURL, Callback = function(v) SetSetting("WebhookURL", v) end})
    Settings:Button({Title = "Test Webhook", Callback = function()
        if Globals.WebhookURL == "" then return Window:Notify({Title="Error", Desc="Webhook URL is empty!", Time=3, Type="error"}) end
        pcall(function()
            SendRequest({Url = Globals.WebhookURL, Method = "POST", Headers = {["Content-Type"]="application/json"}, Body = HttpService:JSONEncode({["content"]="Webhook Test Success!"})})
            Window:Notify({Title="Success", Desc="Test sent!", Time=3})
        end)
    end})
end

-- =====================================================================
-- // AUTOMATION & ABILITY LOOPS (THE ENGINE)
-- =====================================================================
-- Helper for TimeScale
local function SetGameTimescale(TargetVal)
    if GameState ~= "GAME" then return end
    pcall(function()
        local SpeedLabel = game.Players.LocalPlayer.PlayerGui.ReactUniversalHotbar.Frame.timescale.Speed
        local CurrentVal = tonumber(SpeedLabel.Text:match("x([%d%.]+)"))
        if CurrentVal ~= TargetVal then
            ReplicatedStorage.RemoteFunction:InvokeServer("TicketsManager", "UnlockTimeScale")
            task.wait(0.5)
            ReplicatedStorage.RemoteFunction:InvokeServer("TicketsManager", "CycleTimeScale")
        end
    end)
end

-- Radar/Stack Placement Render
RunService.RenderStepped:Connect(function()
    if StackEnabled then
        if not StackSphere then
            StackSphere = Instance.new("Part", workspace)
            StackSphere.Shape, StackSphere.Size = Enum.PartType.Ball, Vector3.new(1.5, 1.5, 1.5)
            StackSphere.Color, StackSphere.Transparency, StackSphere.Material = Color3.fromRGB(0, 255, 0), 0.5, Enum.Material.Neon
            StackSphere.Anchored, StackSphere.CanCollide = true, false
            mouse.TargetFilter = StackSphere
        end
        if mouse.Hit then StackSphere.Position = mouse.Hit.Position end
    elseif StackSphere then
        StackSphere:Destroy(); StackSphere = nil
    end
end)

mouse.Button1Down:Connect(function()
    if StackEnabled and StackSphere and SelectedTower then
        RemoteFunc:InvokeServer("Troops", "Pl\208\176ce", {Rotation = CFrame.new(), Position = StackSphere.Position + Vector3.new(0, 25, 0)}, SelectedTower)
    end
end)

-- Main Background Loop for All Toggles
task.spawn(function()
    while true do
        task.wait(1)

        -- 1. Anti Lag
        if Globals.AntiLag then
            for _, folderName in ipairs({"ClientUnits", "NPCs"}) do
                local f = workspace:FindFirstChild(folderName)
                if f then for _, item in ipairs(f:GetChildren()) do item:Destroy() end end
            end
        end

        -- 2. Auto Skip
        if Globals.AutoSkip then
            local pVote = PlayerGui:FindFirstChild("ReactOverridesVote")
            if pVote and pVote:FindFirstChild("Frame") then 
                pcall(function() RemoteFunc:InvokeServer("Voting", "Skip") end) 
            end
        end

        -- 3. Auto Pickups (Instant Teleport to save resources)
        if Globals.AutoPickups then
            local pickups = workspace:FindFirstChild("Pickups")
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if pickups and hrp then
                for _, item in ipairs(pickups:GetChildren()) do
                    if item:IsA("MeshPart") then
                        hrp.CFrame = item.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.1)
                    end
                end
            end
        end

        -- 4. Auto Abilities
        local TowersFolder = workspace:FindFirstChild("Towers")
        if TowersFolder then
            for _, tower in ipairs(TowersFolder:GetChildren()) do
                local rep = tower:FindFirstChild("TowerReplicator")
                if rep and rep:GetAttribute("OwnerId") == LocalPlayer.UserId then
                    local Name = rep:GetAttribute("Name")
                    local Upgrade = rep:GetAttribute("Upgrade") or 0
                    
                    if Globals.AutoChain and Name == "Commander" and Upgrade >= 2 then
                        pcall(function() RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = tower, Name = "Call Of Arms", Data = {}}) end)
                    end
                    if Globals.AutoDJ and Name == "DJ Booth" and Upgrade >= 3 then
                        pcall(function() RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = tower, Name = "Drop The Beat", Data = {}}) end)
                    end
                    if Globals.AutoNecro and Name == "Necromancer" then
                        pcall(function() RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = tower, Name = "Raise The Dead", Data = {}}) end)
                    end
                    if Globals.AutoMercenary and Name == "Mercenary Base" and Upgrade >= 5 then
                        pcall(function() RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = tower, Name = "Air-Drop", Data = {pathName=1, directionCFrame=CFrame.new(), dist=Globals.MercenaryPath or 195}}) end)
                    end
                    if Globals.AutoMilitary and Name == "Military Base" and Upgrade >= 4 then
                        pcall(function() RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = tower, Name = "Airstrike", Data = {pathName=1, pointToEnd=CFrame.new(), dist=Globals.MilitaryPath or 195}}) end)
                    end
                    if Globals.SellFarms and Name == "Farm" then
                        local label = PlayerGui:FindFirstChild("ReactGameTopGameDisplay", true)
                        local wave = label and tonumber(label.Frame.wave.container.value.Text:match("(%d+)")) or 0
                        if wave >= (Globals.SellFarmsWave or 40) then
                            pcall(function() RemoteFunc:InvokeServer("Troops", "Sell", {Troop = tower}) end)
                        end
                    end
                end
            end
        end

        -- 5. TimeScale
        if Globals.TimeScaleEnabled then
            SetGameTimescale(tonumber(Globals.TimeScaleValue) or 2)
        end
    end
end)

-- Claim Rewards (Runs once in Lobby)
if GameState == "LOBBY" and Globals.ClaimRewards then
    task.spawn(function()
        local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
        local SpinTickets = LocalPlayer:WaitForChild("SpinTickets", 5)
        if SpinTickets and SpinTickets.Value > 0 then
            for i = 1, SpinTickets.Value do
                pcall(function() network.DailySpin["RF:RedeemSpin"]:InvokeServer() end)
                task.wait(0.5)
            end
        end
        for i = 1, 6 do
            pcall(function() network.PlaytimeRewards["RF:ClaimReward"]:InvokeServer(i) end)
            task.wait(0.5)
        end
    end)
end

return TDS
