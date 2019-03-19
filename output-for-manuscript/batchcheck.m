clear all

load('analysis/matching-probability/data/data-1.mat')
Series = Simulation.y_series;
load('analysis/matching-probability/data/data-2.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-3.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-4.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-5.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-6.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-7.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-8.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-9.mat')
Series = [Series Simulation.y_series] ;
load('analysis/matching-probability/data/data-10.mat')
Series = [Series Simulation.y_series] ;

Series = Series *365;



save batchSeries Series


                n = length(Series);
                batchSize = floor(sqrt(n));
                nBatches = floor(n / batchSize);
               
                
                for j = 500 : 100 : 10000
                    batchSize = j;
                    nBatches = floor(n / batchSize);
                    m = zeros(nBatches, 1);
                    for i = 1 : nBatches
                        batch = Series(1 + (i-1)*batchSize : i * batchSize);
                        m(i) = mean(batch);
                    end
                    v_batch = var(m);
                    v = var(Series);
                    value = 0.5 ...
                        * (batchSize ...
                        * v_batch ...
                        / v ...
                        -1 );
                KK(j/100 - 4)  = std(365 * Series) * sqrt(1 + 2*value) / ...
                batchSize;
                end
                
                %% Alternating
                
                n = length(Series);
                batchSize = floor(sqrt(n));
                nBatches = floor(n / batchSize);
               
                
                for j = 500 : 100 : 10000
                    batchSize = j;
                    nBatches = floor(n / batchSize);
                    m = zeros(nBatches, 1);
                    for i = 1 : nBatches
                        batch = Series(1 + (i-1)*batchSize : i * batchSize);
                        m(i) = mean(batch);
                    end
                    
                    v_batch = var(m(1 : 2 : end));
                    v = var(Series);
                    value = 0.5 ...
                        * (batchSize ...
                        * v_batch ...
                        / v ...
                        -1 );
                K(j/100 - 4)  = std(365 * Series) * sqrt(1 + 2*value) / ...
                batchSize;
           
                end        
                
                
                
                
  
            f_sd = std( Series);
        

                n = length(Series);
                k = 0;
batchSizes = 1000 : 100 : 100000;

f_se = zeros (length(batchSizes),1);

                for j = batchSizes
                k = k + 1;   
                %batchSize = floor(sqrt(n));
                batchSize = j ;
                nBatches = floor(n / batchSize);
                m = zeros(nBatches, 1);
                    for i = 1 : nBatches
                        batch = Series(1 + (i-1)*batchSize : i * batchSize);
                        m(i) = mean(batch);
                    end
                v_batch = var(m);
                v = var(Series);
                f_autocorrelation_sum = 0.5 ...
                    * (batchSize ...
                    * v_batch ...
                    / v ...
                    -1 );
        

            f_se(k) = f_sd * sqrt(1 + 2*f_autocorrelation_sum) / ...
                sqrt(length(Series));
            f_autocorrelation_sum2(k) = f_autocorrelation_sum;
                end


    
 
 f = figure();
    f.Position = [0, 0, 162*3, 100*3];  
    plot(batchSizes,f_se)
    title('Batch Size Robustness Check');
    xlabel('Batch Size');
    ylabel('Estimated Standard Error');
    % Save
print('./output-for-manuscript/figures/batchsize.eps', '-depsc2');
                



                
  
            f_sd = std( Series);
        

                n = length(Series);
                k = 0;
batchSizes = 1000 : 100 : 100000;

f_se = zeros (length(batchSizes),1);

                for j = batchSizes
                k = k + 1;   
                %batchSize = floor(sqrt(n));
                batchSize = j ;
                nBatches = floor(n / batchSize);
                m = zeros(floor(nBatches/2), 1);
                    for i = 1 : 2 : nBatches
                        batch = Series(1 + (i-1)*batchSize : i * batchSize);
                        m(1 + (i-1)/2) = mean(batch);
                    end
                v_batch = var(m);
                v = var(Series);
                f_autocorrelation_sum = 0.5 ...
                    * (batchSize ...
                    * v_batch ...
                    / v ...
                    -1 );
        

            f_se(k) = f_sd * sqrt(1 + 2*f_autocorrelation_sum) / ...
                sqrt(length(Series));
            f_autocorrelation_sum2(k) = f_autocorrelation_sum;
                end


    
 
 f = figure();
    f.Position = [0, 0, 162*3, 100*3];  
    plot(batchSizes,f_se)
    title('Batch Size Robustness Check / Alternating Batches');
    xlabel('Batch Size');
    ylabel('Estimated Standard Error');
    % Save
print('./output-for-manuscript/figures/batchsize_alter.eps', '-depsc2');
                

