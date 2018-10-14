function y = optymalizacja(x)

% model = 'vdp';
% load_system('SSiWD_Lab2_blocks.mdl')
% cs = getActiveConfigSet('SSiWD_Lab2_blocks');
% model_cs = cs.copy;
% set_param(model_cs,'Ki',num2str(ki),'Kp.Multiplication',num2str(kp))
% simOut = sim(model, model_cs);



set_param('SSiWD_Lab2_blocks/Ki','Gain',num2str(x(1)))
set_param('SSiWD_Lab2_blocks/Gain1','Gain',num2str(x(2)))
set_param('SSiWD_Lab2_blocks/Gain2','Gain',num2str(x(3)))
sim('SSiWD_Lab2_blocks')
 y = simout(end);