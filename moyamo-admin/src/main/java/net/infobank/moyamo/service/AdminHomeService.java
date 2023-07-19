package net.infobank.moyamo.service;

import net.infobank.moyamo.models.Home;
import net.infobank.moyamo.repository.AdminHomeRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdminHomeService {

    private final AdminHomeRepository homeRepository;

    public AdminHomeService(AdminHomeRepository homeRepository) {
        this.homeRepository = homeRepository;
    }

    /**
     * HOME CRUD
     * */
    public void createHomeGenre(String genre){
        Home home = new Home();
        home.setGenre(genre);
        home.setOrderCount(homeRepository.findMaxOrderCount()
                .map(l -> l.intValue() + 1)
                .orElse(1));
        homeRepository.save(home);
    }

    public List<String> getAllOrders() {
        List<Home> homeList = homeRepository.findAll();
        homeList.sort(Comparator.comparingInt(Home::getOrderCount));
        return homeList.stream().map(Home::getGenre).collect(Collectors.toList());
    }

    @SuppressWarnings("unused")
    @Transactional
    public void updateHomeGenre(String genre){
        Home home = homeRepository.findByGenre(genre).orElse(null);
        if(home==null) return;
        home.setGenre(genre);
    }

    @Transactional
    public void updateHomeOrder(List<String> genres){
        int orderCnt=1;
        for(String genre : genres){
            if(genre.isEmpty())
                continue;

            Home home = homeRepository.findByGenre(genre).orElse(null);
            //해당 장르가 db에 없다면 생성해서 저장해주기
            if(home==null){
                Home home1 = new Home();
                home1.setGenre(genre);
                home1.setOrderCount(orderCnt++);
                homeRepository.save(home1);
            } else {
                home.setOrderCount(orderCnt++);
            }
        }

        //genres에 없었다면 지우기
        List<Home> homeList = homeRepository.findAll();
        for(Home home : homeList){
            if( !genres.contains(home.getGenre()) ) {
                homeRepository.delete(home);
            }
        }
    }

    @SuppressWarnings("unused")
    public void deleteHomeGenre(String genre){
        homeRepository.findByGenre(genre).ifPresent(homeRepository::delete);
    }
}
