package net.infobank.moyamo.domain.badge;

import lombok.ToString;

import java.util.HashMap;

@ToString(callSuper = true)
public class BoardUserActivity extends AbstractUserActivity {

    public BoardUserActivity() {
        if(this.getCumulativeValues() == null) {
            this.setCumulativeValues(new HashMap<>());
        }
    }

}
