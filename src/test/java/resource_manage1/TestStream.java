package resource_manage1;

import java.util.List;
import java.util.function.Supplier;
import java.util.stream.Stream;
import com.google.common.collect.Lists;

public class TestStream {

    public static void main(String[] args) {
        // Lists是Guava中的一个工具类
/*        List<Integer> nums = Lists.newArrayList(1, null, 3, 4, null, 6);
       Long valueCount = nums.stream().filter(num -> num != null).count();
       System.out.println(valueCount);
       
       Stream<Integer> integerStream = Stream.of(1, 2, 3, 5);
       integerStream.forEach(System.out::println);
       Stream<String> stringStream = Stream.of("taobao", "taojiba");
       stringStream.forEach(System.out::println);
       Stream.generate(new Supplier<Double>() {
           @Override
           public Double get() {
               return Math.random();
           }
       });
       Stream.generate(() -> Math.random());
       Stream.generate(Math::random);*/
       Stream.iterate(1, item -> item + 1).limit(10).forEach(System.out::println);
    }
}
