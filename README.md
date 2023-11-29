# FPGA-Atari-Breakout-

![alt text](https://github.com/JPHAGOD/FPGA-Atari-Breakout-/blob/master/Atari.jpg?raw=true)

FPGA-D10LITE VGA Atari-Breakout
By: José Pablo Hernández Alonso

This code can be uploaded and compiled for an FPGA to run an Atari Breakout game. It uses Verilog language.

Game:

The game has 3 powerups:
1. Bar increase.
2. Faster bar.
3. Multiball (up to 3 balls on screen at the time)

And 2 power downs:
1. Bar decrease.
2. Slow bar.

It has 4 rows of blocks with 5 columns (with down, side, and upper coalitions) that you must break.
Each time you end a level the ball will go faster, and the 2-digit counter will be updated.
You have 3 lives; a led count and the color of the ball show you how many lives you have left. But each time you complete a level you recover a life (max. 3).

This proyect was mede for my Program Elements 2 class.

Please check the FPGA DE10 lite pinout: https://www.terasic.com.tw/cgi-bin/page/archive_download.pl?Language=China&No=1021&FID=a13a2782811152b477e60203d34b1baa

Dont forget to download Quartus and install the correct driver for your project.

Enjoy!
