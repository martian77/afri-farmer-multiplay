package uk.ac.sussex.model {
	import uk.ac.sussex.model.valueObjects.DietaryRequirement;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * @author em97
	 */
	public class DietaryRequirementsProxy extends Proxy implements IProxy {
		public static const NAME:String = "DietaryRequirementsProxy";
		public function DietaryRequirementsProxy() {
			super(NAME, new Array());
		}
		public function addRequirements(reqArray:Array):void {
			//this.data = reqArray;
			for each (var dr:DietaryRequirement in reqArray){
				dietaryRequirements.push(dr);
			}
		}
		public function getDietaryRequirement(type:int, level:String):DietaryRequirement {
			for each (var dr:DietaryRequirement in dietaryRequirements){
				if(dr.getType()==type && dr.getLevel() == level){
					return dr;
				}
			}
		}
		public function getTargetRequirements(type:int):Array {
			var reqs:Array = new Array();
			for each (var dr:DietaryRequirement in dietaryRequirements){
				if(dr.getType()==type){
					reqs[dr.getLevel()] = dr;
				}
			}
			return reqs;
		}
		protected function get dietaryRequirements():Array{
			return data as Array;
		}
	}
}