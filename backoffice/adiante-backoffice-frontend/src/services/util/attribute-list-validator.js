/**
 * This class is used to checks the attribute list in order to decide if the attribute list is valid or not to create a instance of the class TaskAttributeLoader.
 */
import TaskAttributesEnum from "../../constants/task-attributes-enum";
export default function canBeShownTaskAttributeLoader(attributeList) {
  if (attributeList.length === 0) {
    return false;
  }else{
    return attributeList.some((attribute) => {
      return (
        attribute.attributeCode == TaskAttributesEnum.VimeoVideo
      );
    });
  }
}