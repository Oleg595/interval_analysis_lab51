addpath(genpath('./m'))
data = [[1, 208.0, 88.9636363636364]
[2, 405.0, 88.9636363636364]
[3, 594.0, 88.9636363636364]
[4, 777.0, 88.9636363636364]
[5, 1002.0, 88.9636363636364]
[6, 1207.0, 88.9636363636364]
[7, 1316.0, 88.9636363636364]
[8, 1615.0, 88.9636363636364]
[9, 1709.0, 88.9636363636364]
[10, 1995.0, 88.9636363636364]];

x = data(:,1)
y = data(:,2)
epsilon = data(:,3)

X = [ x.^0, x ];
lb = [-inf 0];
irp_steam = ir_problem(X, y, epsilon, lb);

%ir_plotbeta(irp_steam)
%grid on
%set(gca, 'fontsize', 12)
%xlabel('\beta_1')
%ylabel('\beta_2')
%title('Information set')

%figure(1, 'position',[0, 0, 800, 600]);
%xlimits = [0 11];
%ir_plotmodelset(irp_steam, xlimits)     # коридор совместных зависимостей
%hold on
%ir_scatter(irp_steam,'bo')              # интервальные измерения
%ir_plotline(b_maxdiag, xlimits, 'r-')
%grid on
%set(gca, 'fontsize', 12)
%xlabel('Fuel consumtion')
%ylabel('Steam quantity')
%title('Set of models compatible with data and constraints')

xp = [5; 7; 17.5; 22.5]
Xp = [xp.^0, xp];

yp = ir_predict(irp_steam, Xp)         # интервальный прогноз значений y в точках xp
ypmid = mean(yp,2)                     # средние значения прогнозных интервалов
yprad = 0.5 * (yp(:,2) - yp(:,1))      # радиус прогнозных интервалов

yprad_relative = 100 * yprad ./ ypmid  # относительная величина неопределенности прогнозов в процентах

%ir_plotmodelset(irp_steam,[0, 25])
%grid on
%hold on
%ir_scatter(irp_steam,'bo')
%ir_scatter(ir_problem(Xp,ypmid,yprad),'r.')
%xlabel('Fuel consumtion')
%ylabel('Steam quantity')
%title('Set of models compatible with data and constraints')
