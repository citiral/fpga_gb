	component system is
		port (
			clk_clk       : in  std_logic := 'X'; -- clk
			reset_reset_n : in  std_logic := 'X'; -- reset_n
			uart_out_rxd  : in  std_logic := 'X'; -- rxd
			uart_out_txd  : out std_logic         -- txd
		);
	end component system;

	u0 : component system
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --      clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n, --    reset.reset_n
			uart_out_rxd  => CONNECTED_TO_uart_out_rxd,  -- uart_out.rxd
			uart_out_txd  => CONNECTED_TO_uart_out_txd   --         .txd
		);

