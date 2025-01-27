% Input five attractions in the city of Hanover
attractions = {'Hanover Zoo', 'New Town Hall', 'Herrenhausen Gardens', 'Lower Saxony State Museum', 'Hannover Messe'};
visitors = [150000, 200000, 100000, 120000, 250000];  % Number of visitors per attraction (unit: number of people)
revenue = [1500000, 2000000, 1000000, 1200000, 3000000];  % Revenue per attraction (in US dollars)

% summation
total_visitors = sum(visitors);
total_revenue = sum(revenue);

%Total number of visitors and total revenue
fprintf('Total Visitors: %d\n', total_visitors);
fprintf('Total Revenue: %d USD\n', total_revenue);

% Scattering the travel burden
target_increase_percentage = 0.5;  % Scattering the travel burden

% Scenic spots with fewer promotions
for i = 1:length(attractions)
    
    new_visitors = visitors(i) * (1 + target_increase_percentage);
    fprintf('Increase the visitors of %s to %d\n', attractions{i}, new_visitors);
    
    % Number of new visitors
    visitors(i) = new_visitors;
end

% Draw a bar chart
x = 1:length(attractions);
figure;

% visitor numbers and revenue
subplot(1,2,1);
b1 = bar(x, visitors, 'FaceColor', [0, 0, 0.5]); % 深蓝色
title('Visitors Count');
set(gca, 'XTickLabel', attractions);
ylabel('Number of Visitors');

subplot(1,2,2);
b2 = bar(x, revenue, 'FaceColor', [0.6, 0.8, 1]); % 浅蓝色
title('Revenue');
set(gca, 'XTickLabel', attractions);
ylabel('Revenue (USD)');