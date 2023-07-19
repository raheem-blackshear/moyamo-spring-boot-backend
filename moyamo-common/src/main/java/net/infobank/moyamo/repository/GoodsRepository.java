package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.shop.Goods;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GoodsRepository extends JpaRepository<Goods, String> {

}
