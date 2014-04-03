package uk.ac.sussex.gameEvents;

import java.util.List;
import java.util.Set;

import uk.ac.sussex.model.*;
import uk.ac.sussex.model.game.Game;

public class CoreAgeCropsEvent extends GameEvent {

	public CoreAgeCropsEvent(Game game) {
		super(game);
	}

	@Override
	public void fireEvent() throws Exception {
		HearthFactory hf = new HearthFactory();
		FieldFactory ff = new FieldFactory();
		AssetFactory af = new AssetFactory();
		Set<Hearth> hearths = hf.fetchGameHearths(game);
		SeasonDetail currentSeason = game.getCurrentSeasonDetail();
		for (Hearth hearth : hearths){
			List<Field> fields = ff.getHearthFields(hearth);
			for (Field field : fields){
				if(field.getCrop() != null){
					AssetCrop crop = (AssetCrop) af.fetchAsset(field.getCrop().getId());
					field = applyHazardHealthReduction(field, currentSeason);
					this.ageCrop(field, crop);
				}
			}
		}
	}
	
	private void ageCrop(Field field, AssetCrop crop) throws Exception {
		try {
			Integer newCropAge = field.getCropAge();
			if(newCropAge == null){
				newCropAge = 0;
			}
			newCropAge ++;
			Integer cropMaturity = crop.getMaturity();
			if(newCropAge >= cropMaturity){
				//Crop is too old, clear it out. 
				field.clearCrop();
			} else if(newCropAge > 1 && newCropAge < cropMaturity) {
				field.setCropAge(newCropAge);
				if(field.getCropWeeded()==0){
					Integer newCropHealth = field.getCropHealth() - crop.getWeedLoss();
					field.setCropHealth(newCropHealth);
				}
			} else {
				field.setCropAge(newCropAge);
			}
			field.save();
		} catch (Exception e) {
			String message = "Problem in CoreAgeCropsEvent.ageCrop(): " + e.getMessage();
			throw new Exception(message);
		}
	}
	private Field applyHazardHealthReduction(Field field, SeasonDetail currentSeason) throws Exception {
		HazardFactory hazardFactory = new HazardFactory();
		FieldHazardHistory fhh = hazardFactory.fetchCurrentFieldHazard(field, currentSeason);
		Integer cropHealth = field.getCropHealth();
		if(fhh!=null){
			CropHazardEffect hazardEffect = hazardFactory.fetchCropHazardEffect(fhh.getCropHazardEffect().getId());
			if(fhh.getMitigated()==FieldHazardHistory.MITIGATED){
				field.setCropHealth(cropHealth - hazardEffect.getMitigatedRed());
			} else {
				field.setCropHealth(cropHealth - hazardEffect.getReduction());
			}
		}
		return field;
	}

	@Override
	public void generateNotifications() throws Exception {
		// TODO Auto-generated method stub
	}
}