local P,CG,TS,RS,LGT=game:GetService("Players"),game:GetService("CoreGui"),game:GetService("TweenService"),game:GetService("ReplicatedStorage"),game:GetService("Lighting")
local LP=P.LocalPlayer
local PG=LP:FindFirstChildOfClass("PlayerGui") or CG
if PG:FindFirstChild("PremiumHub") then PG.PremiumHub:Destroy() end
local SG=Instance.new("ScreenGui",PG)SG.Name="PremiumHub"SG.ResetOnSpawn=false
if LGT:FindFirstChild("PremiumHubBlur") then LGT.PremiumHubBlur:Destroy() end local BLUR=Instance.new("BlurEffect",LGT)BLUR.Name="PremiumHubBlur"BLUR.Size=6
local BG=Color3.fromRGB(15,15,18)local FR=Color3.fromRGB(22,22,26)local AC=Color3.fromRGB(0,255,136)local TX=Color3.fromRGB(240,240,245)local DK=Color3.fromRGB(140,140,145)local OFF=Color3.fromRGB(45,45,50)
local MF=Instance.new("Frame",SG)MF.Size=UDim2.new(0,380,0,220)MF.Position=UDim2.new(0.5,-190,0.4,-110)MF.BackgroundColor3=BG MF.BorderSizePixel=0 MF.Active=true MF.Draggable=true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,10)
local MS=Instance.new("UIStroke",MF)MS.Color=AC MS.Thickness=1.5 MS.Transparency=0.3
local TB=Instance.new("Frame",MF)TB.Size=UDim2.new(1,0,0,35)TB.BackgroundColor3=FR TB.BorderSizePixel=0
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,10)
local TBT=Instance.new("TextLabel",TB)TBT.Size=UDim2.new(1,-80,1,0)TBT.Position=UDim2.new(0,12,0,0)TBT.Text="⚡ FAST HUB // V1.0"TBT.TextColor3=TX TBT.BackgroundTransparency=1 TBT.Font=Enum.Font.GothamBold TBT.TextSize=14 TBT.TextXAlignment=Enum.TextXAlignment.Left
MF.BackgroundTransparency=0.25
TB.BackgroundTransparency=0.25
local function createTopBtn(t,c,p,cb)local b=Instance.new("TextButton",TB)b.Size=UDim2.new(0,22,0,22)b.Position=p b.BackgroundColor3=c b.Text=t b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextSize=13 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(cb)return b end
local OB=Instance.new("TextButton",SG)OB.Size=UDim2.new(0,60,0,60)OB.Position=UDim2.new(0,20,0.5,-30)OB.BackgroundColor3=AC OB.Text="⚡"OB.TextColor3=TX OB.Font=Enum.Font.GothamBold OB.TextSize=20 OB.Visible=false Instance.new("UICorner",OB).CornerRadius=UDim.new(1,0)
local OBS=Instance.new("UIStroke",OB)OBS.Color=TX OBS.Thickness=1.5
local OD,OG
OB.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then OD=i.Position OG=false end end)
OB.InputChanged:Connect(function(i)if OD and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.Mouse)then local p=i.Position if(p-OD).Magnitude>12 then OG=true end if OG then OB.Position=UDim2.fromOffset(p.X-OB.AbsoluteSize.X/2,p.Y-OB.AbsoluteSize.Y/2)end end end)
OB.InputEnded:Connect(function(i)if OD and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1)then if not OG then OB.Visible=false MF.Visible=true BLUR.Size=6 TS:Create(MF,TweenInfo.new(0.3,Enum.EasingStyle.Back),{Size=UDim2.new(0,380,0,220)}):Play()end OD=nil end end)
createTopBtn("–",Color3.fromRGB(60,60,70),UDim2.new(1,-56,0,6.5),function()BLUR.Size=0 TS:Create(MF,TweenInfo.new(0.3,Enum.EasingStyle.Back),{Size=UDim2.new(0,0,0,0)}):Play()task.wait(0.2)MF.Visible=false OB.Visible=true OB.Size=UDim2.new(0,0,0,0)TS:Create(OB,TweenInfo.new(0.3,Enum.EasingStyle.Back),{Size=UDim2.new(0,60,0,60)}):Play()end)
createTopBtn("X",Color3.fromRGB(220,60,60),UDim2.new(1,-28,0,6.5),function()_G.FarmActive,_G.RebirthActive,_G.LootActive=false,false,false BLUR:Destroy()SG:Destroy()end)
local TF=Instance.new("Frame",MF)TF.Size=UDim2.new(0,100,1,-35)TF.Position=UDim2.new(0,0,0,35)TF.BackgroundColor3=FR TF.BorderSizePixel=0
TF.BackgroundTransparency=0.25
local TFL=Instance.new("UIListLayout",TF)TFL.Padding=UDim.new(0,5)
local PC=Instance.new("Frame",MF)PC.Size=UDim2.new(1,-120,1,-45)PC.Position=UDim2.new(0,110,0,40)PC.BackgroundTransparency=1
local PKG=RS:WaitForChild("Packages")local IDX=PKG:WaitForChild("_Index")local SS=IDX["acecateer_knit@1.7.2"].knit.Services.StrengthService local CE=SS.RE.ClickRequested local R2=IDX["acecateer_knit@1.7.2"].knit.Services.RebirtService local RE=R2.RE.RebirthButtonClicked
local tabs={}local cur=nil
local function AddTab(n)local pg=Instance.new("Frame",PC)pg.Size=UDim2.new(1,0,1,0)pg.BackgroundTransparency=1 pg.Visible=false Instance.new("UIListLayout",pg).Padding=UDim.new(0,8)local b=Instance.new("TextButton",TF)b.Size=UDim2.new(1,0,0,35)b.BackgroundColor3=FR b.BorderSizePixel=0 b.Text=n b.TextColor3=DK b.Font=Enum.Font.GothamBold b.TextSize=12 b.MouseButton1Click:Connect(function()for _,t in pairs(tabs)do t.pg.Visible=false t.b.TextColor3=DK end pg.Visible=true b.TextColor3=AC end)tabs[n]={pg=pg,b=b}if not cur then pg.Visible=true b.TextColor3=AC cur=n end return pg end
local function CreateToggle(pp,txt,gv,cb)local F=Instance.new("Frame",pp)F.Size=UDim2.new(1,0,0,42)F.BackgroundColor3=FR Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)local l=Instance.new("TextLabel",F)l.Size=UDim2.new(0.65,0,1,0)l.Position=UDim2.new(0,10,0,0)l.Text=txt l.TextColor3=TX l.Font=Enum.Font.Gotham l.TextSize=12 l.TextXAlignment=Enum.TextXAlignment.Left l.BackgroundTransparency=1 local sw=Instance.new("TextButton",F)sw.Size=UDim2.new(0,40,0,20)sw.Position=UDim2.new(1,-48,0.5,-10)sw.BackgroundColor3=OFF sw.Text="" Instance.new("UICorner",sw).CornerRadius=UDim.new(0,10)local ind=Instance.new("Frame",sw)ind.Size=UDim2.new(0,14,0,14)ind.Position=UDim2.new(0,3,0,3)ind.BackgroundColor3=TX Instance.new("UICorner",ind).CornerRadius=UDim.new(0,7)_G[gv]=false sw.MouseButton1Click:Connect(function()_G[gv]=not _G[gv]if _G[gv]then TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=AC}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(1,-17,0,3),BackgroundColor3=BG}):Play()task.spawn(cb)else TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=OFF}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0,3),BackgroundColor3=TX}):Play()end end)end
local FP=AddTab("Farming")
CreateToggle(FP,"Auto Strength","FarmActive",function()while _G.FarmActive do CE:FireServer()task.wait(0.01)end end)
CreateToggle(FP,"Auto Rebirth","RebirthActive",function()while _G.RebirthActive do RE:FireServer()task.wait(1.2)end end)
local WC={[1]={s=Vector3.new(-933,38,-7),b=Vector3.new(688,37,6)},[2]={s=Vector3.new(-917,38,1705),b=Vector3.new(938,37,1702)}}
local NC=false
game:GetService("RunService").Stepped:Connect(function()if NC then local c=LP.Character if c then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end end end)
local function SN(on)NC=on local c=LP.Character if c then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=not on end end end end
local function GY(x,z)local r=workspace:Raycast(Vector3.new(x,1000,z),Vector3.new(0,-3000,0))return r and r.Position.Y or nil end
local function TP(p)local c=LP.Character if not c then return end local h=c:FindFirstChild("HumanoidRootPart")if h then _G.AntiGameplayPaused=true for _,g in ipairs({workspace:FindFirstChild("GameplayPaused"),RS:FindFirstChild("GameplayPaused"),LP:FindFirstChild("GameplayPaused")})do if g and g:IsA("ValueBase")then pcall(function()g.Value=false end)end end h.Velocity=Vector3.zero h.AssemblyLinearVelocity=Vector3.zero local _,ry=h.CFrame.Rotation:ToOrientation()local x,z=p.X,p.Z local py=p.Y if not NC then local gy=GY(x,z)if gy then py=gy+3 end end h.CFrame=CFrame.new(x,py,z)*CFrame.Angles(0,ry,0)end end
local WBS={}
local function RW()for _,s in ipairs(WBS)do local w1=_G.SelectedWorld==1 s[1].BackgroundColor3=w1 and AC or OFF s[1].TextColor3=w1 and BG or TX s[2].BackgroundColor3=w1 and OFF or AC s[2].TextColor3=w1 and TX or BG end end
local function CWS(pp)local F=Instance.new("Frame",pp)F.Size=UDim2.new(1,0,0,42)F.BackgroundColor3=FR Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)local l=Instance.new("TextLabel",F)l.Size=UDim2.new(0.45,0,1,0)l.Position=UDim2.new(0,10,0,0)l.Text="Select World"l.TextColor3=TX l.Font=Enum.Font.Gotham l.TextSize=12 l.TextXAlignment=Enum.TextXAlignment.Left l.BackgroundTransparency=1 local b1=Instance.new("TextButton",F)b1.Size=UDim2.new(0,80,0,28)b1.Position=UDim2.new(1,-168,0.5,-14)b1.Text="World 1"b1.Font=Enum.Font.GothamBold b1.TextSize=12 Instance.new("UICorner",b1).CornerRadius=UDim.new(0,6)local b2=Instance.new("TextButton",F)b2.Size=UDim2.new(0,80,0,28)b2.Position=UDim2.new(1,-84,0.5,-14)b2.Text="World 2"b2.Font=Enum.Font.GothamBold b2.TextSize=12 Instance.new("UICorner",b2).CornerRadius=UDim.new(0,6)WBS[#WBS+1]={b1,b2}b1.MouseButton1Click:Connect(function()_G.SelectedWorld=1 RW()end)b2.MouseButton1Click:Connect(function()_G.SelectedWorld=2 RW()end)end
local TPg=AddTab("Teleport")
CWS(TPg)
local function CB(pp,txt,c,cb)local b=Instance.new("TextButton",pp)b.Size=UDim2.new(1,0,0,40)b.BackgroundColor3=c b.Text=txt b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextSize=13 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(cb)end
CB(TPg,"Teleport to Spawn",Color3.fromRGB(70,130,255),function()local w=WC[_G.SelectedWorld]if not w then return end TP(w.s)SN(false)end)
CB(TPg,"Teleport to Best Area",AC,function()local w=WC[_G.SelectedWorld]if not w then return end SN(true)TP(w.b)end)
local PPS=game:GetService("ProximityPromptService")local UIS=game:GetService("UserInputService")
local PM={}
local function SI(p)if p then if not PM[p]then PM[p]={p.MaxActivationDistance,p.RequiresLineOfSight}end p.MaxActivationDistance=10000 p.RequiresLineOfSight=false end end
local function RP()for p,o in pairs(PM)do if p and p.Parent then p.MaxActivationDistance=o[1]p.RequiresLineOfSight=o[2]end end PM={} end
local function CP(p)pcall(function()PPS:PromptButtonHoldBegan(p)end)task.wait(0.05)pcall(function()p:InputBegan(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)task.wait(0.05)pcall(function()p:InputEnded(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)task.wait(0.05)pcall(function()PPS:PromptButtonHoldEnded(p)end)end
local function BF()local c=LP.Character for _,n in ipairs{"BagFull","InventoryFull","BackpackFull"}do local a=LP:GetAttribute(n)if a~=nil then return a end if c then local a2=c:GetAttribute(n)if a2~=nil then return a2 end local v=c:FindFirstChild(n)if v and v:IsA("ValueBase")then return v.Value end end end local inv=c and(c:FindFirstChild("Inventory")or c:FindFirstChild("Bag"))or LP:FindFirstChild("Inventory")if inv then local cap=inv:GetAttribute("MaxSlots")or LP:GetAttribute("MaxSlots")or 40 local n=0 for _ in ipairs(inv:GetChildren())do n=n+1 end return n>=cap end return false end
local BZ={[1]="Zone_13"}
local function FZ(w)local zf=workspace:FindFirstChild("zones")if not zf then return nil,nil end local zn=BZ[w]local z=zn and zf:FindFirstChild(zn)or nil if z then return z,z:IsA("BasePart")and z.Position or(z:FindFirstChildWhichIsA("BasePart")and z:FindFirstChildWhichIsA("BasePart").Position)or nil end local bp=WC[w].b local bz,bd=nil,math.huge for _,z2 in ipairs(zf:GetChildren())do local cp=z2:IsA("BasePart")and z2.Position or(z2:FindFirstChildWhichIsA("BasePart")and z2:FindFirstChildWhichIsA("BasePart").Position)or nil if cp then local d=(cp-bp).Magnitude if d<bd then bd=d bz=z2 end end end return bz,bz and(bz:IsA("BasePart")and bz.Position or(bz:FindFirstChildWhichIsA("BasePart")and bz:FindFirstChildWhichIsA("BasePart").Position))or nil end
local function ZL(z)local out,seen={},{}for _,v in ipairs(z:GetDescendants())do if v:IsA("BasePart")then local pr=v:FindFirstChildOfClass("ProximityPrompt")or(v.Parent and v.Parent:FindFirstChildOfClass("ProximityPrompt"))if pr and not seen[pr]then seen[pr]=true out[#out+1]={p=v,pr=pr}end end end if #out==0 then for _,v in ipairs(z:GetDescendants())do if v:IsA("BasePart")and v~=z then out[#out+1]={p=v,pr=v:FindFirstChildOfClass("ProximityPrompt")}end end end return out end
local LT=AddTab("Loot")
CWS(LT)
_G.SelectedWorld=1
RW()
CreateToggle(LT,"Auto Collect Loot From Best Zone","LootActive",function()
while _G.LootActive do
if BF()then
local w=WC[_G.SelectedWorld]TP(w.s)SN(false)RP()
while _G.LootActive and BF()do task.wait(1)end
else
local w=_G.SelectedWorld
SN(true)
local z,zp=FZ(w)
if not z then TP(WC[w].b)task.wait(3)z,zp=FZ(w)end
TP(zp or WC[w].b)
task.wait(2.5)
local loot=z and ZL(z)or{}
if #loot==0 then task.wait(2)loot=z and ZL(z)or{} end
for _,it in ipairs(loot)do
if not _G.LootActive then break end
if BF()then break end
if it.pr then SI(it.pr)end
SN(true)
TP(it.p.Position)
task.wait(0.4)
if it.pr then CP(it.pr)end
task.wait(0.8)
end
end
end
SN(false)RP()_G.AntiGameplayPaused=false
end)
local MP=AddTab("Misc")
CreateToggle(MP,"Anti-AFK Avoidance","AntiAFK",function()local VU=game:GetService("VirtualUser")LP.Idled:Connect(function()if _G.AntiAFK then VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end end)end)
