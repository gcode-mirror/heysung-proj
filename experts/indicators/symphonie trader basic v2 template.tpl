<chart>
comment=3 minutes 48 seconds left to bar end
symbol=EURUSD
period=5
leftpos=33568
digits=5
scale=8
graph=1
fore=1
grid=0
volume=0
scroll=1
shift=1
ohlc=1
askline=0
days=0
descriptions=0
shift_size=25
fixed_pos=0
window_left=19
window_top=4
window_right=987
window_bottom=496
window_type=1
background_color=0
foreground_color=16775408
barup_color=32768
bardown_color=8388736
bullcandle_color=2330219
bearcandle_color=2763429
chartline_color=0
volumes_color=13458026
grid_color=0
askline_color=255
stops_color=255

<window>
height=273
<indicator>
name=main
<object>
type=23
object_name=Original Created by Symphonie Trader System
period_flags=0
create_time=1317628611
description=Symphonie
color=8388352
font=Arial Handwriting
fontsize=8
angle=0
background=0
corner=2
x_distance=5
y_distance=10
</object>
<object>
type=21
object_name=time
period_flags=0
create_time=1321000872
description=                                 <--3:48
color=65535
font=Verdana
fontsize=13
angle=0
background=0
time_0=1321008000
value_0=1.365710
</object>
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=EJ_CandleTime
flags=275
window_num=0
</expert>
shift_0=0
draw_0=0
color_0=0
style_0=0
weight_0=0
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Bands
flags=275
window_num=0
<inputs>
BandsPeriod=20
BandsShift=0
BandsDeviations=2.00000000
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=11186720
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=11186720
style_1=0
weight_1=0
shift_2=0
draw_2=0
color_2=11186720
style_2=0
weight_2=0
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Symphonie_Trendline_Indikator
flags=275
window_num=0
<inputs>
CCIPeriod=63
ATRPeriod=18
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=16748574
style_0=0
weight_0=2
shift_1=0
draw_1=0
color_1=255
style_1=0
weight_1=2
shift_2=0
draw_2=0
color_2=0
style_2=0
weight_2=0
shift_3=0
draw_3=0
color_3=0
style_3=0
weight_3=0
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=24
<indicator>
name=Custom Indicator
<expert>
name=Symphonie_Market_Emotion_Indikator
flags=275
window_num=2
<inputs>
SSP=7
Kmax=50.60000000
CountBars=3000
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=16748574
style_0=0
weight_0=4
shift_1=0
draw_1=2
color_1=255
style_1=0
weight_1=4
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=50
<indicator>
name=Custom Indicator
<expert>
name=Symphonie_Sentiment_Indikator
flags=275
window_num=3
<inputs>
period=12
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=0
style_0=0
weight_0=4
shift_1=0
draw_1=2
color_1=16748574
style_1=0
weight_1=4
shift_2=0
draw_2=2
color_2=255
style_2=0
weight_2=4
min=-0.000100
max=0.000100
period_flags=0
show_data=1
<object>
type=23
object_name=Symphonie x4bd Repro
period_flags=0
create_time=1321000802
description=Sentiment Direction = Up-Bull
color=65280
font=Arial
fontsize=12
angle=0
background=0
corner=0
x_distance=10
y_distance=15
</object>
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Symphonie Extreme Indicator v2
flags=275
window_num=3
<inputs>
PriceActionFilter=1
Length=3
MajorCycleStrength=4
UseCycleFilter=0
UseFilterSMAorRSI=1
FilterStrengthSMA=12
FilterStrengthRSI=21
MinorAlert=0
MajorAlert=1
MajorGoneAlert=1
SoundAlert=1
EmailAlert=0
TrackMajorCycleHistory=1
WaitForClose=1
MajorGoneLookBackBars=40
note1=alert all = 0, none = 4
note2=buy only = 1, sell only = 2
alertsOption=0
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=15794175
style_0=0
weight_0=2
shift_1=0
draw_1=2
color_1=16748574
style_1=0
weight_1=3
shift_2=0
draw_2=2
color_2=255
style_2=0
weight_2=3
shift_3=0
draw_3=2
color_3=0
style_3=0
weight_3=1
shift_4=0
draw_4=2
color_4=0
style_4=0
weight_4=1
shift_5=0
draw_5=12
color_5=0
style_5=0
weight_5=0
shift_6=0
draw_6=3
color_6=16776960
style_6=0
weight_6=0
arrow_6=108
shift_7=0
draw_7=3
color_7=16711935
style_7=0
weight_7=0
arrow_7=108
min=-1.200000
max=1.200000
period_flags=0
show_data=1
</indicator>
</window>
</chart>

