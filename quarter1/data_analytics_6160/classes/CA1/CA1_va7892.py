
# coding: utf-8

# In[1]:

# Function: Percentile
import math 

def percentile(sequence, p):
  sequence.sort()
  try: 
    if p < 0 or p > 100:
      raise Exception()
  except:
    print ('p should be between 0 to 100')
  
  i = (p/100)*len(sequence)
  
  f = math.floor(i)
  c = math.ceil(i)
  
  if f == c: 
    return (sequence[f-1] + sequence[f])/2 
  else: 
    return sequence[c-1]


# In[2]:

a =  percentile([3310, 3355, 3450, 3650, 3480, 3480, 3490, 3520, 3540, 3550,  3730, 3925], 85
)
print (a)

a =  percentile([1 , 2, 3, 4, 5, 6, 7, 9 , 10, 8], 80)
print (a)


# In[3]:

# Function named: “Pearson_correl”
def Pearson_correl(x1, x2, sample=True):
  try: 
    if len(x1) != len(x2):
      raise Exception()
  except:
    print ('please enter data sets of equal length')
    return 

  def mean(x):
    return sum(x)/len(x)

  mean_x1 = mean(x1)
  mean_x2 = mean(x2)

  n = len(x1)

  if sample: 
    sample_deviation_x1 = math.sqrt(sum([(x - mean_x1)**2 for x in x1]) / (n - 1))
    sample_deviation_x2 = math.sqrt(sum([(x - mean_x2)**2 for x in x2]) / (n - 1))
    sample_covariance = sum([(x1[i] - mean_x1)*(x2[i] - mean_x2) for i in xrange(n)]) / (n-1)

    return sample_covariance/(sample_deviation_x1 * sample_deviation_x2)
  else: 
    population_deviation_x1 = math.sqrt(sum([(x - mean_x1)**2 for x in x1]) / n)
    population_deviation_x2 = math.sqrt(sum([(x - mean_x2)**2 for x in x2]) / n)
    population_covariance = sum([(x1[i] - mean_x1)*(x2[i] - mean_x2) for i in xrange(n)]) / n

    return population_covariance/(population_deviation_x1 * population_deviation_x2)


# In[4]:

# Function named “z_score”
def z_score(sample, x):
    mean_sample = sum(sample)/len(sample)
    standand_deviation_sample = math.sqrt(sum([(s - mean_sample)**2 for s in sample]) / (len(sample) - 1))
    
    return (x - mean_sample)/standand_deviation_sample


# In[ ]:



