package net.infobank.moyamo;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MoyamoEventServerApplicationTests {

    @Test
    void contextLoads() {
        //
        Integer i = 1;
        Assertions.assertThat(i).isNotEqualTo(10);
    }

}
