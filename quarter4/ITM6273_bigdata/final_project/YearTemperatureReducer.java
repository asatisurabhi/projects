import java.io.IOException;
import java.lang.StringBuilder;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;


public class YearTemperatureReducer
  extends Reducer<Text, IntWritable, Text, Text> {
  
  @Override
  public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
    
    StringBuilder strOutput = new StringBuilder();

    double i = 0;

    for (IntWritable value : values) {
    	if(i > 0) {
            strOutput.append(",");
    	}
        strOutput.append(value.toString());
        i++;
    }
    context.write(key, new Text(strOutput.toString()));
  }
}
