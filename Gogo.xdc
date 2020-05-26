set_property PACKAGE_PIN L15 [get_ports USERLED]
set_property PACKAGE_PIN V15 [get_ports LINK_LED]
set_property IOSTANDARD LVCMOS33 [get_ports LINK_LED]
set_property IOSTANDARD LVCMOS33 [get_ports USERLED]

set_property PACKAGE_PIN F4 [get_ports sys_clk_i_0]
set_property IOSTANDARD SSTL15 [get_ports sys_clk_i_0]

set_property PACKAGE_PIN F5 [get_ports reset]
set_property IOSTANDARD SSTL15 [get_ports reset]

set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.GENERAL.XADCENHANCEDLINEARITY ON [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPPOWERDOWN ENABLE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
