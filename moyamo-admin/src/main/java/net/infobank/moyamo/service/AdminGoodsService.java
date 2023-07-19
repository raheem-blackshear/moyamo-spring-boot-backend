package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.GoodsDto;
import net.infobank.moyamo.repository.GoodsRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@AllArgsConstructor
public class AdminGoodsService {

	GoodsRepository goodsRepository;

	@Transactional
	public GoodsDto findGoods(String id) {
		return goodsRepository.findById(id).map(GoodsDto::of).orElse(null);
	}


}
