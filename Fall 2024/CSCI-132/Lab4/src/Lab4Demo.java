import java.util.Arrays;

public class Lab4Demo {

    public static void main(String[] args) {
        
        int[] array1 = {97, 43, 80, 80, 63, 20, 67, 8, 20, 80};
        System.out.println(Arrays.toString(array1));
        calculate_statistics(array1);
        System.out.println("---------------------------------------------");
        
        int[] array2 = {11, 45, 27, 55, 11};
        System.out.println(Arrays.toString(array2));
        calculate_statistics(array2);
        System.out.println("---------------------------------------------");
        
        int[] array3 = {44, 44, 44, 81, 53, 53, 53, 44};
        System.out.println(Arrays.toString(array3));
        calculate_statistics(array3);
        System.out.println("---------------------------------------------");
    }

    private static void calculate_statistics(int[] array) {
        calculate_mean(array);
        calculate_median(array);
        calculate_mode(array);
    }

    private static void calculate_mean(int[] array) {
        int sum = 0;
        for (int num : array) {
            sum += num;
        }
        double mean = (double) sum / array.length;
        System.out.println("Mean: " + mean);
    }

    private static void calculate_median(int[] array) {
        Arrays.sort(array);
        double median;
        if (array.length % 2 == 0) {
            median = (array[array.length / 2 - 1] + array[array.length / 2]) / 2.0;
        } else {
            median = array[array.length / 2];
        }
        System.out.println("Median: " + median);
    }

    private static void calculate_mode(int[] array) {
        int maxValue = 0, maxCount = 0;

        for (int i = 0; i < array.length; i++) {
            int count = 0;
            for (int j = 0; j < array.length; j++) {
                if (array[j] == array[i]) count++;
            }
            if (count > maxCount) {
                maxCount = count;
                maxValue = array[i];
            }
        }
        System.out.println("Mode: " + maxValue);
    }
}
