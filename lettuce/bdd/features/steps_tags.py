'''
Created on Feb 9, 2011

@author: camerondawson
'''
from features.models import TagModel, CompanyModel
from lettuce import step


'''
######################################################################

                     TAG STEPS

######################################################################
'''

@step(u'create a new tag with (that name|name "(.*)")')
def create_tag_with_name(step, stored, tag):
    tagModel = TagModel()
    tag = tagModel.get_stored_or_store_name(stored, tag)

    post_payload = {"companyId": CompanyModel().get_seed_resid()[0],
                    "name": tag
                   }
    tagModel.create(post_payload)



@step(u'tag with (that name|name "(.*)") (exists|does not exist)')
def check_tag_foo_existence(step, stored, tag, existence):
    tagModel = TagModel()
    tag = tagModel.get_stored_or_store_name(stored, tag)
    tagModel.verify_existence_on_root(existence = existence,
                                      params = {"name": tag})


@step(u'delete the tag with (that name|name "(.*)")')
def delete_tag_with_tag_foo(step, stored, tag):
    tagModel = TagModel()
    tag = tagModel.get_stored_or_store_name(stored, tag)

    tagModel.delete(tag)

